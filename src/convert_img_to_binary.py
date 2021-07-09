import sys, argparse, numpy
import cv2
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("src", help="the source image")
    parser.add_argument("dest", help="the dest text")

    if(len(sys.argv) < 3):
        parser.print_help()
    else:
        args = parser.parse_args()
        img = cv2.imread(args.src, 2)
        img = cv2.resize(img, (256, 256))
        print(img.shape)
        _, bw_img = cv2.threshold(img, 0,255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

        binary = numpy.where(bw_img == 255, 1, bw_img)
        print(len(binary)) 
        with open(args.dest, 'w') as dest:
            dest.write('[\n')
            for r in range(0, len(binary) - 1):
                dest.write('\t')
                dest.write(str(binary[r].tolist()))
                dest.write(',\n')
            dest.write('\t')
            dest.write(str(binary[-1].tolist()))
            dest.write('\n]')  
main()
