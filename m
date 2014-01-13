Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 50F846B5D1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 23:08:01 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0DN7sup025292; Mon, 13 Jan 2014 23:07:55 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id a0UY3EKgYzxP; Mon, 13 Jan 2014 23:07:54 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0DN7laR025286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Jan 2014 23:07:48 GMT
Message-ID: <1389654461.14987.32.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Mon, 13 Jan 2014 23:07:41 +0000
In-Reply-To: <69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
References: <cover.1389601138.git.liezhi.yang@windriver.com>
	<69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: data.py: convert "__" to "-" for PREFERRED_VERSION
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
X-List-Received-Date: Mon, 13 Jan 2014 23:08:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-01-13 at 03:19 -0500, Robert Yang wrote:
> We can set the PREFERRED_VERSION from the command line:
> 
> $ export BB_PRESERVE_ENV=1
> $ PREFERRED_VERSION_recipe="pv" bitbake recipe
> 
> But it doesn't work if the recipe name contain the "-" since we can't
> use "-" in shell's variable name,  use '__' instead of '-' in the env
> will make it work.
> 
> We also need update the doc, I will mark the bug as "doc changes
> required".
> 
> [YOCTO #4965]
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/data.py |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Should we do this just for PREFERRED_VERSION or all environment
variables? I can't think of a case we'd use __ currently but I can think
of other variable names where this mapping would help...

Any strong opinions?

Cheers,

Richard

> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index 5840803..666cdcb 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -171,11 +171,20 @@ def expandKeys(alterdata, readdata = None):
>  
>  def inheritFromOS(d, savedenv, permitted):
>      """Inherit variables from the initial environment."""
> +    # We can set the PREFERRED_VERSION_recipe from the shell env, but we
> +    # can't use "-" in shell's variable name, so we use '__' instead of
> +    # '-' in the env, and translate it back here.
> +    preferred_version_re = re.compile('PREFERRED_VERSION_.*__')
> +
>      exportlist = bb.utils.preserved_envvars_exported()
>      for s in savedenv.keys():
>          if s in permitted:
>              try:
> -                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
> +                if preferred_version_re.match(s):
> +                    s_new = s.replace('__', '-')
> +                    d.setVar(s_new, getVar(s, savedenv, True), op = 'from env')
> +                else:
> +                    d.setVar(s, getVar(s, savedenv, True), op = 'from env')
>                  if s in exportlist:
>                      d.setVarFlag(s, "export", True, op = 'auto env export')
>              except TypeError:



