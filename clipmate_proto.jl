using HTTP
testurl = "https://t.co/xSFZsvl4PY?amp=1"
testurl_result = "https://dietercastel.com/2019/11/28/restore-private-communication-together"

testurl_utm = "https://www.mo.be/commentaar/parlement-moet-pieter-de-crem-en-andr-flahaut-opheldering-vragen?utm_content=buffer5b52b&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer"
testurl_result = "https://www.mo.be/commentaar/parlement-moet-pieter-de-crem-en-andr-flahaut-opheldering-vragen" 

urlRegex = r"http(s)*://"


eolToken = "$"
paramSplitToken = "&"
caseInsensitive = "i" 
paramValue = "=.+"

paramNameStrings = ["utm_.+", "amp.*"]
#utmRX = r"utm_.+=.+&"
utmRX = Regex(string(paramNameStrings[1],paramValue,paramSplitToken)) 
#utmLastRX = r"utm_.+=.+$" 
utmRX = Regex(string(paramNameStrings[1],paramValue,eolToken)) 
#ampRX = r"amp.*=.+&" 
ampRX = Regex(string(paramNameStrings[2],paramValue,paramSplitToken)) 
#ampLastRX = r"amp.*=.+$" 
ampLastRX = Regex(string(paramNameStrings[2],paramValue,paramSplitToken)) 
#TODO: 
# spref=tw

qmLastRX = r"\?$"


# TODO write test cases.

function cleanUTM(url)
	result = replace(url, utmRX => "")
	result = replace(result, utmLastRX => "")
	result = cleanQM(result) 
end

function cleanAMP(url)
	result = replace(url, ampRX => "")
	result = replace(url, ampLastRX => "")
	result = cleanQM(result) 
end

function cleanQM(url)
	result = replace(url, qmLastRX => "")
end

function popRedirect(url)
	r = HTTP.request("GET", url, redirect=false)
	return r
end

function undoRedir(url, redirCount)
	r = popRedirect(url)
	while HTTP.isredirect(r)
		r = popRedirect(HTTP.header(r, "location"))
	end
	println(r.request)
	println(r)
	println(HTTP.header(r, "location"))
	return (string(HTTP.header(r.request,"host"),r.request.target),redirCount+1)
end

#res = undoRedir(testurl,0)
#println("The result is $res")
#println(clipboard())

function monitorClipboard()
	cp = clipboard()	
	if match(urlRegex, cp)	== nothing
		return
	else 
		(tg, cnt) = undoRedir(cp,0)		
		println(tg)	
		println(cnt)	
	end
end

function mapClipboard(func)
	clipboard(func(clipboard()))
end

#clipboard()

# TODO: implement the following:

# - Create a public unlinked database with link hashes -> target
# - Allow private mode (unpublished local-only repo)
# - Do statistics on the public DB
# - Speedup (skip the t*r/g*e/b*tly/f*b) redirects 
# - Update local DB with likely links for you?
# - filter "utm_" tracking parameters

#print(cleanUTM(clipboard()))
