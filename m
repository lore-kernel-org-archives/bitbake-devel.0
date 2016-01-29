Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 12F55731D5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 Jan 2016 00:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0T017RR018576; Fri, 29 Jan 2016 00:01:07 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id D6HhimcARIoY; Fri, 29 Jan 2016 00:01:06 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0T015bS018571
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 29 Jan 2016 00:01:06 GMT
Message-ID: <1454025665.10340.56.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andre McCurdy <armccurdy@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 29 Jan 2016 00:01:05 +0000
In-Reply-To: <1453941798-11670-4-git-send-email-armccurdy@gmail.com>
References: <1453941798-11670-1-git-send-email-armccurdy@gmail.com>
	<1453941798-11670-4-git-send-email-armccurdy@gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 3/3] data.py: sort variables being output by emit_func()
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
X-List-Received-Date: Fri, 29 Jan 2016 00:01:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-01-27 at 16:43 -0800, Andre McCurdy wrote:
> Sorting variables and separating those being exported from those
> being
> unset greatly improves the readability of OE run.do_configure, etc,
> shell scripts.
> 
> Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
> ---
>  lib/bb/data.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 70ba56b..07f4bba 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -270,7 +270,13 @@ def exported_vars(d):
>  def emit_func(func, o=sys.__stdout__, d = init()):
>      """Emits all items in the data store in a format such that it
> can be sourced by a shell."""
>  
> -    keys = (key for key in d.keys() if not key.startswith("__") and
> not d.getVarFlag(key, "func"))
> +    o.write('\n')
> +    keys = sorted(key for key in d.keys() if not
> key.startswith("__") and not d.getVarFlag(key, "func") and not
> d.getVarFlag(key, 'unexport'))
> +    for key in keys:
> +        emit_var(key, o, d, False)
> +
> +    o.write('\n')
> +    keys = sorted(key for key in d.keys() if not
> key.startswith("__") and not d.getVarFlag(key, "func") and
> d.getVarFlag(key, 'unexport'))
>      for key in keys:
>          emit_var(key, o, d, False)

FWIW d.keys() is very slow and best avoided if we can.

Since this code only generally runs at execution time rather than
parsing, its probably not a big deal but thought I'd mention it.

Cheers,

Richard

