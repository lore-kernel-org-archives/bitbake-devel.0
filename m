Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id AEA476B5D8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 11:15:14 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id 2A3A7F811D8; Mon, 13 Jan 2014 04:15:13 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id 601C4F8119A;
	Mon, 13 Jan 2014 04:15:10 -0700 (MST)
Message-ID: <52D3CAC4.5090807@mlbassoc.com>
Date: Mon, 13 Jan 2014 04:15:16 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1389601138.git.liezhi.yang@windriver.com>
	<69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
In-Reply-To: <69aa90ef3b947f39f49563b84a10c226d7df61d8.1389601138.git.liezhi.yang@windriver.com>
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
X-List-Received-Date: Mon, 13 Jan 2014 11:15:15 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2014-01-13 01:19, Robert Yang wrote:
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
>   bitbake/lib/bb/data.py |   11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index 5840803..666cdcb 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -171,11 +171,20 @@ def expandKeys(alterdata, readdata = None):
>
>   def inheritFromOS(d, savedenv, permitted):
>       """Inherit variables from the initial environment."""
> +    # We can set the PREFERRED_VERSION_recipe from the shell env, but we
> +    # can't use "-" in shell's variable name, so we use '__' instead of
> +    # '-' in the env, and translate it back here.
> +    preferred_version_re = re.compile('PREFERRED_VERSION_.*__')
> +
>       exportlist = bb.utils.preserved_envvars_exported()
>       for s in savedenv.keys():
>           if s in permitted:
>               try:
> -                d.setVar(s, getVar(s, savedenv, True), op = 'from env')
> +                if preferred_version_re.match(s):
> +                    s_new = s.replace('__', '-')
> +                    d.setVar(s_new, getVar(s, savedenv, True), op = 'from env')
> +                else:
> +                    d.setVar(s, getVar(s, savedenv, True), op = 'from env')
>                   if s in exportlist:
>                       d.setVarFlag(s, "export", True, op = 'auto env export')
>               except TypeError:
>

Are you sure this is correct for the 's in exportlist' case?

Perhaps the change should look like this (which is also easier to read):
@@ -175,6 +175,8 @@ def inheritFromOS(d, savedenv, permitted):
      for s in savedenv.keys():
          if s in permitted:
              try:
+                if preferred_version_re.match(s):
+                    s = s.replace('__', '-')
                  d.setVar(s, getVar(s, savedenv, True), op = 'from env')
                  if s in exportlist:
                      d.setVarFlag(s, "export", True, op = 'auto env export')

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

