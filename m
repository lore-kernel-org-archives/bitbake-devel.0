Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AA30060670
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Sep 2016 21:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8LLHRUa026774; Wed, 21 Sep 2016 22:17:27 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dZmEmF7KvUF6; Wed, 21 Sep 2016 22:17:27 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8LLHOer026765
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Sep 2016 22:17:25 +0100
Message-ID: <1474492644.7207.340.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Roman Savchenko <gmstima@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 21 Sep 2016 22:17:24 +0100
In-Reply-To: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
References: <1474388588-1111-1-git-send-email-gmstima@gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake: Correct broken symlink behaviour
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
X-List-Received-Date: Wed, 21 Sep 2016 21:17:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

On Tue, 2016-09-20 at 19:23 +0300, Roman Savchenko wrote:
> From: Roman Savchenko <roman.savchenko@attocapital.com>
> 
> Unlink broken symlink.

This really needs a few more details about the problem and how an issue
occurs. I can understand from reading the patch but not from the commit
message.


> Signed-off-by: Roman Savchenko <gmstima@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py
> b/bitbake/lib/bb/fetch2/__init__.py
> index 6ef0c6f..a752c6c 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -925,6 +925,17 @@ def rename_bad_checksum(ud, suffix):
>      bb.utils.movefile(ud.localpath, new_localpath)
>  
>  
> +def try_symlink(source, link_name):
> +    """
> +    Tries to make link to passed source if link name does not
> +    exist.
> +    """
> +    if not os.path.exists(link_name):
> +        if os.path.islink(link_name):
> +            os.unlink(link_name)
> +
> +        os.symlink(source, link_name)
> +

I don't think the function name is right. "try" implies its fine if it
doesn't work out. In reality its more like "symlink if its invalid".
"create_valid_symlink" whilst long is probably more reflective of what
it does but I'm sure we could still do better :/. 

You could add "or the symlink is invalid" to the function description
too.

Cheers,

Richard

