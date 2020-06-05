package kr.co.smartdatacorp.web.bean.util;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

//ignore "bytes" when return json format
@JsonIgnoreProperties({ "bytes" })
public class FileMeta {

	private String fileName;

	private String fileSize;

	private String fileTypeCd;

	private String imageurl;

	private String imgMime;

	private Integer atchFileSeq;

	public String getImgMime() {
		return imgMime;
	}

	public void setImgMime(String imgMime) {
		this.imgMime = imgMime;
	}


	public String getImageurl() {
		return imageurl;
	}

	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}

	private byte[] bytes;

	// setters & getters
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileTypeCd() {
		return fileTypeCd;
	}

	public void setFileType(String fileTypeCd) {
		this.fileTypeCd = fileTypeCd;
	}

	public byte[] getBytes() {
		return bytes;
	}

	public void setBytes(byte[] bytes) {
		this.bytes = bytes;
	}

    public Integer getAtchFileSeq() {
        return atchFileSeq;
    }

    public void setAtchFileSeq(Integer atchFileSeq) {
        this.atchFileSeq = atchFileSeq;
    }


}