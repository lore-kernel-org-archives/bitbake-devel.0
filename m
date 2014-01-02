Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C73D760D31
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jan 2014 13:06:56 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s02D6pCv017127; Thu, 2 Jan 2014 13:06:51 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id h4HtXs8uWzej; Thu,  2 Jan 2014 13:06:51 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s02D6jMY017121
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 2 Jan 2014 13:06:47 GMT
Message-ID: <1388668002.11527.100.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Thu, 02 Jan 2014 13:06:42 +0000
In-Reply-To: <c26d7a72feb5c465b89cbc719e97afec4a5c0892.1388159725.git.liezhi.yang@windriver.com>
References: <cover.1388159725.git.liezhi.yang@windriver.com>
	<c26d7a72feb5c465b89cbc719e97afec4a5c0892.1388159725.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: replace 3 spaces with 4
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
X-List-Received-Date: Thu, 02 Jan 2014 13:06:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-12-27 at 23:55 +0800, Robert Yang wrote:
> A part of fetch2/__init__.py and yacc.py uses 3 spaces as the indent, I
> think that they should be typos.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py |  8 ++++----
>  bitbake/lib/ply/yacc.py           | 12 ++++++------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 8fdf59c..439a44a 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1263,10 +1263,10 @@ class FetchMethod(object):
>          return
>  
>      def clean(self, urldata, d):
> -       """
> -       Clean any existing full or partial download
> -       """
> -       bb.utils.remove(urldata.localpath)
> +        """
> +        Clean any existing full or partial download
> +        """
> +        bb.utils.remove(urldata.localpath)
>  
>      def try_premirror(self, urldata, d):
>          """

The __init__ change is fine and I've taken it, the yacc code is actually
a copy from upstream so its better to leave that alone even if its not
entirely correct.

Cheers,

Richard


