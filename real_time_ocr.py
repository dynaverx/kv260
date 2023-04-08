# coding: utf-8
# =====================================================================
#  
#
# =====================================================================

from imutils.video import VideoStream
from imutils.video import FPS
from imutils.object_detection import non_max_suppression
import numpy as np
import argparse
import time
import cv2
import pytesseract

def nothing(x):
     pass

def process_detection(roi):

    # recognizing text
    config = '--psm 10 --oem 1 -c tessedit_char_whitelist=0123456789'
    text = pytesseract.image_to_string(roi[0], config=config)

    return text, roi[1]

def box_extractor(scores, geometry, min_confidence):

    num_rows, num_cols = scores.shape[2:4]
    rectangles = []
    confidences = []

    for y in range(num_rows):
        scores_data = scores[0, 0, y]
        x_data0 = geometry[0, 0, y]
        x_data1 = geometry[0, 1, y]
        x_data2 = geometry[0, 2, y]
        x_data3 = geometry[0, 3, y]
        angles_data = geometry[0, 4, y]

        for x in range(num_cols):
            if scores_data[x] < min_confidence:
                continue

            offset_x, offset_y = x * 4.0, y * 4.0

            angle = angles_data[x]
            cos = np.cos(angle)
            sin = np.sin(angle)

            box_h = x_data0[x] + x_data2[x]
            box_w = x_data1[x] + x_data3[x]

            end_x = int(offset_x + (cos * x_data1[x]) + (sin * x_data2[x]))
            end_y = int(offset_y + (cos * x_data2[x]) - (sin * x_data1[x]))
            start_x = int(end_x - box_w)
            start_y = int(end_y - box_h)

            rectangles.append((start_x, start_y, end_x, end_y))
            confidences.append(scores_data[x])

    return rectangles, confidences


def get_arguments():
    ap = argparse.ArgumentParser()
    ap.add_argument('-v', '--video', type=str, default="1.avi",
                    help='path to optional video file')
    ap.add_argument('-east', '--east', type=str, default="frozen_east_text_detection.pb",
                    help='path to EAST text detection model')
    ap.add_argument('-c', '--min_confidence', type=float, default=0.5,
                    help='minimum confidence to process a region')
    ap.add_argument('-w', '--width', type=int, default=320,
                    help='resized image width (multiple of 32)')
    ap.add_argument('-e', '--height', type=int, default=320,
                    help='resized image height (multiple of 32)')
    ap.add_argument('-p', '--padding', type=float, default=0.0,
                    help='padding on each ROI border')
    arguments = vars(ap.parse_args())

    return arguments


if __name__ == '__main__':

    args = get_arguments()

    w, h = None, None
    new_w, new_h = args['width'], args['height']
    ratio_w, ratio_h = None, None

    layer_names = ['feature_fusion/Conv_7/Sigmoid', 'feature_fusion/concat_3']

    print("[INFO] loading EAST text detector...")
    net = cv2.dnn.readNet(args["east"])

    if not args.get('video', False):
        print("[INFO] starting video stream...")
        vs = VideoStream(src=0).start()
        time.sleep(1)

    else:
        
        # Create a window
        windowName = 'Detection - HUD TUBITAK SAGE tesseract-4.1.1'
        cv2.namedWindow(windowName)
        vs = cv2.VideoCapture(args['video'])
        

    fps = FPS().start()
    first_iter=True
    sensitivity = 85
    lower_white = np.array([0,0,255-sensitivity])
    upper_white = np.array([255,sensitivity,255])
    while True:

        frame = vs.read()
       
        frame = frame[1] if args.get('video', False) else frame
        src=frame.copy()

        if frame is None:
            break
            
        if first_iter:
           avg = np.float32(frame)
           first_iter = False
        cv2.accumulateWeighted(frame, avg, 0.005)
        result1 = cv2.convertScaleAbs(avg)
        hsv1 = cv2.cvtColor(result1, cv2.COLOR_BGR2HSV)
             
        mask11 = cv2.inRange(hsv1, lower_white, upper_white)
        mask21 = cv2.inRange(hsv1, (175,50,20), (180,255,255))
        mask1 = cv2.bitwise_or(mask11, mask21)
        # get the index of the white areas and make them green in the main frame
        for i in zip(*np.where(mask1 == 255)):
                result1[i[0], i[1], 0] = 36
                result1[i[0], i[1], 1] = 255
                result1[i[0], i[1], 2] = 0

        #ir
        cv2.line(result1, (238, 69) , (238, 166), (0, 255, 0), 2)
        cv2.line(result1, (238, 69) , (243, 69), (0, 255, 0), 2)
        cv2.line(result1, (238, 166) , (243, 166), (0, 255, 0), 2)
        cv2.line(result1, (230, 69) , (238, 74), (0, 255, 0), 2)
        cv2.line(result1, (230, 79) , (238, 74), (0, 255, 0), 2)
        
        #iz
        cv2.line(result1, (243, 97) , (243, 138), (0, 255, 0), 2)
        cv2.line(result1, (243, 97) , (238, 97), (0, 255, 0), 2)
        cv2.line(result1, (243, 138) , (238, 138), (0, 255, 0), 2)
        
        result1 = cv2.putText(result1, "KGK", (312,16), cv2.FONT_HERSHEY_SIMPLEX, 0.5, 
                 (0, 255, 0), 1, cv2.LINE_AA, False)

   


         
                
        hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV) 
        mask1 = cv2.inRange(hsv, lower_white, upper_white)
        mask2 = cv2.inRange(hsv, (175,50,20), (180,255,255))
        mask = cv2.bitwise_or(mask1, mask2)
        # get the index of the white areas and make them green in the main frame
        for i in zip(*np.where(mask == 255)):
                frame[i[0], i[1], 0] = 36
                frame[i[0], i[1], 1] = 255
                frame[i[0], i[1], 2] = 0
        
        tmp_=frame.copy()
        # get the index of the white areas and make them green in the main frame
        for i in zip(*np.where(mask == 0)):
                tmp_[i[0], i[1], 0] = 0
                tmp_[i[0], i[1], 1] = 0
                tmp_[i[0], i[1], 2] = 0
        
        # Convert image to image gray
        
        tmp = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
        # Applying thresholding technique
        _, alpha = cv2.threshold(tmp, 0, 255, cv2.THRESH_BINARY)
        # Using cv2.split() to split channels 
        # of coloured image
        b, g, r = cv2.split(tmp_)
        # Making list of Red, Green, Blue
        # Channels and alph
        rgba = [b, g, r, alpha]
        # Using cv2.merge() to merge rgba
        # into a coloured/multi-channeled image
        dst = cv2.merge(rgba, 4)
                        
        orig = frame.copy()
        orig_h, orig_w = orig.shape[:2]
        
        if w is None or h is None:
            h, w = frame.shape[:2]
            ratio_w = w / float(new_w)
            ratio_h = h / float(new_h)

        frame = cv2.resize(frame, (new_w, new_h))

        blob = cv2.dnn.blobFromImage(frame, 1.0, (new_w, new_h), (123.68, 116.78, 103.94),
                                     swapRB=True, crop=False)
        net.setInput(blob)
        scores, geometry = net.forward(layer_names)

        rectangles, confidences = box_extractor(scores, geometry, min_confidence=args['min_confidence'])
        boxes = non_max_suppression(np.array(rectangles), probs=confidences)

#################################################################################################################################        
        for (start_x, start_y, end_x, end_y) in boxes:

            start_x = int(start_x * ratio_w)
            start_y = int(start_y * ratio_h)
            end_x = int(end_x * ratio_w)
            end_y = int(end_y * ratio_h)

            dx = int((end_x - start_x) * args['padding'])
            dy = int((end_y - start_y) * args['padding'])

            start_x = max(0, start_x - dx)
            start_y = max(0, start_y - dy)
            end_x = min(w, end_x + (dx * 2))
            end_y = min(h, end_y + (dy * 2))
            
            roi = orig[start_y:end_y, start_x:end_x]

            # recognizing text
            #config = '-l eng --psm 10 --oem 3 -c tessedit_char_whitelist=0123456789'
            #text = pytesseract.image_to_string(roi, config=config)
            #text = re.sub('\D', '',text)
            #print(f"[INFO] text: {text,start_y,end_y, start_x,end_x}")
            cv2.rectangle(orig, (start_x, start_y), (end_x, end_y), (0, 0, 255), 2)
            #if(text!='' and int(text)>0):
            # 	cv2.putText(orig, text, (start_x, start_y),cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 0, 255), 2)             
            
               
##################################################################################################################################
        fps.update()

        cv2.imshow(windowName, orig)
        cv2.imshow("low resolution hud dvr", src)
        cv2.imshow("moving assets removed from hud", result1)
        cv2.imshow("endgame", dst)
        key = cv2.waitKey(1) & 0xFF

        if key == ord('q'):
            break

    fps.stop()
    print(f"[INFO] elapsed time {round(fps.elapsed(), 2)}")
    print(f"[INFO] approx. FPS : {round(fps.fps(), 2)}")

    if not args.get('video', False):
        vs.stop()

    else:
        vs.release()

    cv2.destroyAllWindows()
