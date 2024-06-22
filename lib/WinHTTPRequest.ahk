#Include json.ahk

Class WinHTTPRequest {
	static secureProtocols := [0x8, 0x20, 0x80, 0x200, 0x800, 0xA8]

	__New(method, url, async := false) {
		this.whr := ComObject("WinHttp.WinHttpRequest.5.1")
		this.whr.Open(method, url, async)
		this.whr.Option[0] := 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.67'
	}
	Send(data?) {
		if IsSet(data) {
			if IsObject(data) && IsSet(JSON)
				data := JSON.stringify(data)
		}
		this.whr.Send(data?)
		return this
	}
	WaitForResponse(t := -1) => (this.whr.WaitForResponse(t), this)
	ResponseText => this.whr.ResponseText
	SetRequestHeader(header, value) => (this.whr.SetRequestHeader(header, value), this)
	Status => this.whr.Status
	StatusText => this.whr.StatusText
	ResponseBody => this.whr.ResponseBody
	UserAgentString {
		get => this.whr.option[0]
		set {
			if !value is String
				Throw TypeError("Expected a string. Got " type(value) " instead.")
			this.whr.Option[0] := value
			return this
		}
	}
	option[i] {
		get => this.whr.option[i]
		set => this.whr.option[i] := value
	}
	secureProtocols {
		get => this.whr.Option[9]
		set {
			if !value is Integer
				try value += 0
				catch
					Throw TypeError("Expected an integer. Got " type(Value) " instead.")
			if !WinHTTPRequest.checkFlag(value, this.secureProtocols)
				Throw Error("Invalid secure protocol.")
			this.whr.Option[9] := Value
			return this
		}
	}
	abort() => (this.whr.abort(), this)
	setCredentials(username, password, flags) => (this.whr.SetCredentials(username, password, flags), this)
	setTimeouts(resolveTimeout := -1, connectTimeout := -1, sendTimeout := -1, receiveTimeout := -1) => (this.whr.SetTimeouts(resolveTimeout, connectTimeout, sendTimeout, receiveTimeout), this)
	__Delete() => this.whr := ""
	static checkFlag(flag, set) {
		mask := 0
		for i, v in set
			mask |= v
		return (flag & mask) == flag
	}
	ParseResponse(map:=false, keepBool := false) {
		if this.Status != 200
			Throw Error("Request failed with status " this.Status " (" this.StatusText ")")
		return JSON.parse(this.ResponseText, map, keepBool)
	}
	FormatResponse() {
		if this.Status != 200
			Throw Error("Request failed with status " this.Status " (" this.StatusText ")")
		return JSON.stringify(JSON.parse(this.ResponseText), 2)
	}
}