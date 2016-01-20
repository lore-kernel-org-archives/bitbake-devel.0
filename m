Return-Path: <anibal.limon@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id C5E886FFD8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 15:46:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga104.fm.intel.com with ESMTP; 20 Jan 2016 07:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,321,1449561600"; d="scan'208";a="894699346"
Received: from alimonb-mobl1.zpn.intel.com (HELO [10.219.5.154])
	([10.219.5.154])
	by orsmga002.jf.intel.com with ESMTP; 20 Jan 2016 07:46:36 -0800
To: Ross Burton <ross.burton@intel.com>, bitbake-devel@lists.openembedded.org
References: <1453295662-13333-1-git-send-email-ross.burton@intel.com>
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
Message-ID: <569FAC47.4050901@linux.intel.com>
Date: Wed, 20 Jan 2016 09:48:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
	Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1453295662-13333-1-git-send-email-ross.burton@intel.com>
Subject: Re: [PATCH] fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 20 Jan 2016 15:46:38 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi Ross,

The code looks good only two comments,

	- Will be good if you add this case when HEAD isn't available to the
unittest. [1]
	
	- I don't thinks is a good idea to log something inside fetcher (since
fetcher is a helper module) i.e. when use shared states the logic calls
checkstatus for every possible sstate available and it will show you a
lot of warnings if isn't. I have a ticket for change this behavior [2].

Cheers,
	alimon

[1] http://git.openembedded.org/bitbake/tree/lib/bb/tests/fetch.py#n727
[2] https://bugzilla.yoctoproject.org/show_bug.cgi?id=8727

On 01/20/2016 07:14 AM, Ross Burton wrote:
> The core change here is to fall back to GET requests if HEAD is rejected in the
> checkstatus() method, as you can't do a HEAD on Amazon S3 (used by Github
> archives).  This meant removing the monkey patch that the default method was GET
> and adding a fixed redirect handler that doesn't reset to GET.
> 
> Also, change the way the opener is constructed from an if/elif cluster to a
> conditionally constructed list.
> 
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  bitbake/lib/bb/fetch2/wget.py | 65 ++++++++++++++++++++++++++++---------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index c8c6d5c..dafa068 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -235,38 +235,57 @@ class Wget(FetchMethod):
>  
>              return exported
>  
> -        def head_method(self):
> -            return "HEAD"
> -
> +        class HTTPMethodFallback(urllib2.BaseHandler):
> +            """
> +            Fallback to GET if HEAD is not allowed (405 HTTP error)
> +            """
> +            def http_error_405(self, req, fp, code, msg, headers):
> +                fp.read()
> +                fp.close()
> +
> +                newheaders = dict((k,v) for k,v in req.headers.items()
> +                                  if k.lower() not in ("content-length", "content-type"))
> +                return self.parent.open(urllib2.Request(req.get_full_url(),
> +                                                        headers=newheaders,
> +                                                        origin_req_host=req.get_origin_req_host(),
> +                                                        unverifiable=True))
> +
> +            """
> +            Some servers (e.g. GitHub archives, hosted on Amazon S3) return 403
> +            Forbidden when they actually mean 405 Method Not Allowed.
> +            """
> +            http_error_403 = http_error_405
> +
> +        class FixedHTTPRedirectHandler(urllib2.HTTPRedirectHandler):
> +            """
> +            urllib2.HTTPRedirectHandler resets the method to GET on redirect,
> +            when we want to follow redirects using the original method.
> +            """
> +            def redirect_request(self, req, fp, code, msg, headers, newurl):
> +                newreq = urllib2.HTTPRedirectHandler.redirect_request(self, req, fp, code, msg, headers, newurl)
> +                newreq.get_method = lambda: req.get_method()
> +                return newreq
>          exported_proxies = export_proxies(d)
>  
> +        handlers = [FixedHTTPRedirectHandler, HTTPMethodFallback]
> +        if export_proxies:
> +            handlers.append(urllib2.ProxyHandler())
> +        handlers.append(CacheHTTPHandler())
>          # XXX: Since Python 2.7.9 ssl cert validation is enabled by default
>          # see PEP-0476, this causes verification errors on some https servers
>          # so disable by default.
>          import ssl
> -        ssl_context = None
>          if hasattr(ssl, '_create_unverified_context'):
> -            ssl_context = ssl._create_unverified_context()
> -
> -        if exported_proxies == True and ssl_context is not None:
> -            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler,
> -                    urllib2.HTTPSHandler(context=ssl_context))
> -        elif exported_proxies == False and ssl_context is not None:
> -            opener = urllib2.build_opener(CacheHTTPHandler,
> -                    urllib2.HTTPSHandler(context=ssl_context))
> -        elif exported_proxies == True and ssl_context is None:
> -            opener = urllib2.build_opener(urllib2.ProxyHandler, CacheHTTPHandler)
> -        else:
> -            opener = urllib2.build_opener(CacheHTTPHandler)
> -
> -        urllib2.Request.get_method = head_method
> -        urllib2.install_opener(opener)
> -
> -        uri = ud.url.split(";")[0]
> +            handlers.append(urllib2.HTTPSHandler(context=ssl._create_unverified_context()))
> +        opener = urllib2.build_opener(*handlers)
>  
>          try:
> -            urllib2.urlopen(uri)
> -        except:
> +            uri = ud.url.split(";")[0]
> +            r = urllib2.Request(uri)
> +            r.get_method = lambda: "HEAD"
> +            opener.open(r)
> +        except urllib2.URLError as e:
> +            bb.warn("checkstatus() urlopen failed: %s" % e)
>              return False
>          return True
>  
> 

