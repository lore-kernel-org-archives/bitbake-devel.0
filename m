Return-Path: <Mark.Asselstine@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 827FE77381
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 02:44:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id uBL2inNe003511
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Tue, 20 Dec 2016 18:44:49 -0800
Received: from tal.localnet (147.11.119.89) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 20 Dec 2016 18:44:48 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Dec 2016 21:44:48 -0500
Message-ID: <2878173.NEvyd15rBg@tal>
Organization: Wind River 
User-Agent: KMail/5.1.3 (Linux/4.4.0-47-generic; KDE/5.18.0; x86_64; ; )
In-Reply-To: <1482288080-12147-1-git-send-email-mark.asselstine@windriver.com>
References: <1482288080-12147-1-git-send-email-mark.asselstine@windriver.com>
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: fetch2/wget: fixup case with no netrc data
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
X-List-Received-Date: Wed, 21 Dec 2016 02:44:51 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Sorry, I just noticed I left the 'bitbake:' prefix on the short log as I 
originally prepared this commit in poky. I will send a V2 with this dropped. 
Sorry for the noise.

Mark


On Tuesday, December 20, 2016 9:41:20 PM EST Mark Asselstine wrote:
> Commit 873e33d0479e977520106b65d149ff1799195bf6 [bitbake: fetch2/wget:
> add Basic Auth from netrc to checkstatus()] causes "Fetcher failure
> for URL: 'https://www.example.com/'. URL https://www.example.com/
> doesn't work." on new builds when a user has a .netrc file but there
> is no default and no matching host. The call to netrc.authenticators()
> will return None in these cases and the attempted assignment to the
> 3-tuple will raise a TypeError exception. Add the TypeError to the
> exceptions caught to get around this issue.
> 
> Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
> ---
>  lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 88349c9..737b98d 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -320,7 +320,7 @@ class Wget(FetchMethod):
>                  n = netrc.netrc()
>                  login, unused, password =
> n.authenticators(urllib.parse.urlparse(uri).hostname)
> add_basic_auth("%s:%s" % (login, password), r)
> -            except (ImportError, IOError, netrc.NetrcParseError):
> +            except (TypeError, ImportError, IOError,
> netrc.NetrcParseError): pass
> 
>              opener.open(r)



