package co.ninuc.ninucco.common.util;

import org.apache.commons.codec.binary.Base64;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

public class FileConversionUtil {
    static void base64ToImg(String fileName, String base64Str)throws IOException {
        byte[] byteArray = Base64.decodeBase64(base64Str);
        try(OutputStream stream = new FileOutputStream("C:\\SSAFY\\out\\"+fileName+".png")){
            stream.write(byteArray);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
