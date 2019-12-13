using HTTP
testurl = "https://t.co/t3tRfZTOUl?amp=1"
testurl_result = "https://dietercastel.com/2019/11/28/restore-private-communication-together"

testurl_utm = "https://www.mo.be/commentaar/parlement-moet-pieter-de-crem-en-andr-flahaut-opheldering-vragen?utm_content=buffer5b52b&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer"
testurl_result = "https://www.mo.be/commentaar/parlement-moet-pieter-de-crem-en-andr-flahaut-opheldering-vragen" 

utmreg = r"utm_.+=.+&"
utmlast = r"utm_.+=.+$" 
removeQM = r"\?$"


function cleanUTM(url)
	tmp = replace(url, utmreg => "")
	tmp = replace(tmp, utmlast => "")
	tmp = replace(tmp, removeQM => "")
end

println("The result is $tmp")

#r = HTTP.request("GET", testurl, redirect= false)


# TODO: implement the following:

# - Create a public unlinked database with link hashes -> target
# - Allow private mode (unpublished local-only repo)
# - Do statistics on the public DB
# - Speedup (skip the t*r/g*e/b*tly/f*b) redirects 
# - Update local DB with likely links for you?
# - filter "utm_" tracking parameters


