﻿package com.plter.utils.zip
{

	import flash.utils.ByteArray;

	/**
	 * This class represents a member of a zip archive.  ZipFile
	 * will give you instances of this class as information
	 * about the members in an archive.  On the other hand ZipOutput
	 * needs an instance of this class to create a new member.
	 *
	 * @author David Chang
	 */
	public class ZipEntry
	{

		// some members are internal as ZipFile will need to set these directly
		// where their accessor does type conversion
		private var _name:String;
		private var _size:int=-1;
		private var _compressedSize:int=-1;
		private var _crc:uint;
		/** @private */
		internal var dostime:uint=0;
		private var _method:int=-1; // compression method
		private var _extra:ByteArray; // optional extra field data for entry
		private var _comment:String=""; // optional comment string for entry
		// The following flags are used only by ZipOutput
		/** @private */
		internal var flag:int; // bit flags
		/** @private */
		internal var version:int; // version needed to extract
		/** @private */
		internal var offset:int; // offset of loc header

		/**
		 * Creates a zip entry with the given name.
		 * @param name the name. May include directory components separated
		 * by '/'.
		 */
		public function ZipEntry(path:String)
		{
			_name=path;
		}

		/**
		 * Returns the entry name.  The path components in the entry are
		 * always separated by slashes ('/').
		 */
		public function get path():String
		{
			return _name;
		}

		/**
		 * Gets the time of last modification of the entry.
		 * @return the time of last modification of the entry, or -1 if unknown.
		 */
		public function get time():Number
		{
			var d:Date=new Date(((dostime >> 25) & 0x7f) + 1980, ((dostime >> 21) & 0x0f) - 1, (dostime >> 16) & 0x1f, (dostime >> 11) & 0x1f, (dostime >> 5) & 0x3f, (dostime & 0x1f) << 1);
			return d.time;
		}

		/**
		 * Sets the time of last modification of the entry.
		 * @time the time of last modification of the entry.
		 */
		public function set time(time:Number):void
		{
			var currentDate:Date=new Date(time);

			if (currentDate.getFullYear() < 1980)
				currentDate=new Date(1980, 1, 1, 0, 0, 0);

			dostime=((currentDate.getFullYear() - 1980) << 25) | (currentDate.getMonth() << 21) | (currentDate.getDate() << 16) | (currentDate.getHours() << 11) | (currentDate.getMinutes() << 5) | (currentDate.getSeconds() >> 1);
		}

		/**
		 * Gets the size of the uncompressed data.
		 */
		public function get size():int
		{
			return _size;
		}

		/**
		 * Sets the size of the uncompressed data.
		 */
		public function set size(size:int):void
		{
			_size=size;
		}

		/**
		 * Gets the size of the compressed data.
		 */
		public function get compressedSize():int
		{
			return _compressedSize;
		}

		/**
		 * Sets the size of the compressed data.
		 */
		public function set compressedSize(csize:int):void
		{
			_compressedSize=csize;
		}

		/**
		 * Gets the crc of the uncompressed data.
		 */
		public function get crc():uint
		{
			return _crc;
		}

		/**
		 * Sets the crc of the uncompressed data.
		 */
		public function set crc(crc:uint):void
		{
			_crc=crc;
		}

		/**
		 * Gets the compression method.
		 */
		public function get method():int
		{
			return _method;
		}

		/**
		 * Sets the compression method.  Only DEFLATED and STORED are
		 * supported.
		 */
		public function set method(method:int):void
		{
			_method=method;
		}

		/**
		 * Gets the extra data.
		 */
		public function get extra():ByteArray
		{
			return _extra;
		}

		/**
		 * Sets the extra data.
		 */
		public function set extra(extra:ByteArray):void
		{
			_extra=extra;
		}

		/**
		 * Gets the extra data.
		 */
		public function get comment():String
		{
			return _comment;
		}

		/**
		 * Sets the entry comment.
		 */
		public function set comment(comment:String):void
		{
			_comment=comment;
		}

		/**
		 * Gets true, if the entry is a directory.  This is solely
		 * determined by the name, a trailing slash '/' marks a directory.
		 */
		public function get isDirectory():Boolean
		{
			return _name.charAt(_name.length - 1) == '/';
		}

		/**
		 * Gets the string representation of this ZipEntry.  This is just
		 * the name as returned by name.
		 */
		public function toString():String
		{
			return _name;
		}

	}

}