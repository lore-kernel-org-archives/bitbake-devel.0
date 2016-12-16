Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5E5D277407
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Dec 2016 16:59:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id uBGGxt5s016446
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 16 Dec 2016 08:59:55 -0800 (PST)
Received: from msp-dhcp26.wrs.com (172.25.34.26) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 16 Dec 2016 08:59:54 -0800
To: Matthew McClintock <msm-oss@mcclintock.net>,
	<bitbake-devel@lists.openembedded.org>
References: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <7610040c-55e8-10e1-8451-5c5842c82a60@windriver.com>
Date: Fri, 16 Dec 2016 10:59:53 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1481880762-26028-1-git-send-email-msm-oss@mcclintock.net>
Subject: Re: [PATCH] fetch2/wget: add Basic Auth from netrc to checkstatus()
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
X-List-Received-Date: Fri, 16 Dec 2016 16:59:54 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

There was a recent change to wget that allows it to do an 'ASKPASS' when it
needs credentials.

This is how we handle that at Wind River.  We define a WGET_ASKPASS program that
knows how to answer the credential questions [or prompt the user outside of the
build system, i.e. via gnome].

(Passing anything on the command line, or even via .netrc is really dangerous.
The command line due to 'ps' leakage on a multi-user system, and .netrc as the
credentials are stored in plain text.)

Anyway, something to consider.

--Mark

On 12/16/16 3:32 AM, Matthew McClintock wrote:
> fetch2/wget uses urllib to check the status of the mirrors, wget will
> use netrc to pass login and password information however checkstatus
> will skip that.
> 
> This adds netrc login and password to checkstatus so both will work the
> same.
> 
> Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
> ---
>  lib/bb/fetch2/wget.py | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 6dfb27b..88349c9 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -305,12 +305,24 @@ class Wget(FetchMethod):
>              r = urllib.request.Request(uri)
>              r.get_method = lambda: "HEAD"
>  
> -            if ud.user:
> +            def add_basic_auth(login_str, request):
> +                '''Adds Basic auth to http request, pass in login:password as string'''
>                  import base64
> -                encodeuser = base64.b64encode(ud.user.encode('utf-8')).decode("utf-8")
> +                encodeuser = base64.b64encode(login_str.encode('utf-8')).decode("utf-8")
>                  authheader =  "Basic %s" % encodeuser
>                  r.add_header("Authorization", authheader)
>  
> +            if ud.user:
> +                add_basic_auth(ud.user, r)
> +
> +            try:
> +                import netrc, urllib.parse
> +                n = netrc.netrc()
> +                login, unused, password = n.authenticators(urllib.parse.urlparse(uri).hostname)
> +                add_basic_auth("%s:%s" % (login, password), r)
> +            except (ImportError, IOError, netrc.NetrcParseError):
> +                 pass
> +
>              opener.open(r)
>          except urllib.error.URLError as e:
>              if try_again:
> 


