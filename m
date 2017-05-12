Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0A320600B3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 13:54:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v4CDsbJr006725
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Fri, 12 May 2017 06:54:37 -0700
Received: from soho-mhatle-m.local (172.25.36.230) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 12 May 2017 06:54:36 -0700
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	<bitbake-devel@lists.openembedded.org>
References: <1494577570-6677-1-git-send-email-richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <6210109a-1d23-e245-00df-a70594eabb0b@windriver.com>
Date: Fri, 12 May 2017 08:54:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
	Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1494577570-6677-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH] data_smart: Don't cache/process capitalised overrides
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
X-List-Received-Date: Fri, 12 May 2017 13:54:39 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 5/12/17 3:26 AM, Richard Purdie wrote:
> Bitbake now only processes overrides which are lowercase since
> this allows variables like SRC_URI not to pollute the cache.
> 
> There was a corner case where XXX_append_SomeThing was still being
> processed (yet XXX_append_SomeThing_SomeOtherThing would not be).
> 
> This patch ensures we're consistent and only process lowercase
> _append/_prepend and _remove operators too.

I just realized a ramification of the previous and this change.  It prevents
recipe/package names with uppercase characters in them since overrides will no
longer be processed (like pn-....).

This is something that probably should be documented.  "Don't use uppercase!"

--Mark

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/data_smart.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 7dc1c68..7b09af5 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -39,7 +39,7 @@ from bb.COW  import COWDictBase
>  logger = logging.getLogger("BitBake.Data")
>  
>  __setvar_keyword__ = ["_append", "_prepend", "_remove"]
> -__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
> +__setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>[^A-Z]*))?$')
>  __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t :]+}")
>  __expand_python_regexp__ = re.compile(r"\${@.+?}")
>  
> 


