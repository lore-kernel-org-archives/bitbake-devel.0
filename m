Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D7C64ED6
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 17:43:12 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web11.660.1677519781934688234
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 09:43:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lqBwK0HI;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1CC9824000A;
	Mon, 27 Feb 2023 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677519780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GUeQqHBLdS3hpQkDvJAyp7HeSvA6fS1AtRmTfr5IEuI=;
	b=lqBwK0HI2i55MZefeOkZiWAZve5v+s9IyDpEOGYxSD9JNNqHCwWpPf0LxYoO/BvXKBec6h
	Cq7Hos9sXCXgV9YgTJ6Ok1FzB1OxlYsRC0fvDnKX8py81mSYDgGbyZbLcUXy9Ks1mPvJFd
	aHpUM2J2vmY4YQbQ57VCo+97rcpTqRNplST8ze3Yl+qMRbBAd1iKUzSEwoYeD+2fkXS91l
	cVkZ9IGCWK861YlqechL0L7xqCH3eJnsc6rAfsXg7bV6jTiG5AqXbK2mLCnRyTNBeCufxL
	GAgRzlBR1yiEWg4QmQWBixyWwJHlFXmCGwr2zxAFV52IyITZGTgLWBMzKpvtqA==
Message-ID: <3ffcb4a2-f71e-cf47-29fd-bb2073316821@bootlin.com>
Date: Mon, 27 Feb 2023 18:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: Ever ATILANO <ever.atilano@smile.fr>, Yoann CONGAL
 <yoann.congal@smile.fr>, YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/2] bitbake-user-manual: update Hello
 World example
Content-Language: en-US
To: Fawzi KHABER <fawzi.khaber@smile.fr>, bitbake-devel@lists.openembedded.org
References: <20230227135115.29202-1-fawzi.khaber@smile.fr>
 <20230227135115.29202-2-fawzi.khaber@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20230227135115.29202-2-fawzi.khaber@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 17:43:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14502

Hi Fawzi

Many thanks for this patch too. Much appreciated!

Good catch finding this outdated part of the BitBake manual.

See my comments below...

On 27.02.23 at 14:51, Fawzi KHABER wrote:
> Fix broken link "Obtaining bitbake".
> Update documentation for the bitbake hello world example, the output was
> outdated.
> Fix LAYERSERIES_COMPAT warning by adding dunfell as default compatible release.
> Add proper formating for base.bbclass command.
>
> Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
> Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
> Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
> ---
>   .../bitbake-user-manual-hello.rst             | 53 +++++++------------
>   1 file changed, 18 insertions(+), 35 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> index 722dc5a2..0cf81ce4 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-hello.rst
> @@ -18,7 +18,7 @@ it.
>   Obtaining BitBake
>   =================
>   
> -See the :ref:`bitbake-user-manual/bitbake-user-manual-hello:obtaining bitbake` section for
> +See the :ref:`bitbake-user-manual/bitbake-user-manual-intro:obtaining bitbake` section for
>   information on how to obtain BitBake. Once you have the source code on
>   your machine, the BitBake directory appears as follows::
>   
> @@ -52,7 +52,7 @@ directory to where your local BitBake files are and run the following
>   command::
>   
>     $ ./bin/bitbake --version
> -  BitBake Build Tool Core version 1.23.0, bitbake version 1.23.0
> +  BitBake Build Tool Core version 2.3.1
>   
>   The console output tells you what version
>   you are running.
> @@ -130,23 +130,11 @@ Following is the complete "Hello World" example.
>       directory. Run the ``bitbake`` command and see what it does::
>   
>          $ bitbake
> -       The BBPATH variable is not set and bitbake did not
> -       find a conf/bblayers.conf file in the expected location.
> +       ERROR: The BBPATH variable is not set and bitbake did not find a conf/bblayers.conf file in the expected location.
>          Maybe you accidentally invoked bitbake from the wrong directory?
> -       DEBUG: Removed the following variables from the environment:
> -       GNOME_DESKTOP_SESSION_ID, XDG_CURRENT_DESKTOP,
> -       GNOME_KEYRING_CONTROL, DISPLAY, SSH_AGENT_PID, LANG, no_proxy,
> -       XDG_SESSION_PATH, XAUTHORITY, SESSION_MANAGER, SHLVL,
> -       MANDATORY_PATH, COMPIZ_CONFIG_PROFILE, WINDOWID, EDITOR,
> -       GPG_AGENT_INFO, SSH_AUTH_SOCK, GDMSESSION, GNOME_KEYRING_PID,
> -       XDG_SEAT_PATH, XDG_CONFIG_DIRS, LESSOPEN, DBUS_SESSION_BUS_ADDRESS,
> -       _, XDG_SESSION_COOKIE, DESKTOP_SESSION, LESSCLOSE, DEFAULTS_PATH,
> -       UBUNTU_MENUPROXY, OLDPWD, XDG_DATA_DIRS, COLORTERM, LS_COLORS
> -
> -    The majority of this output is specific to environment variables that
> -    are not directly relevant to BitBake. However, the very first
> -    message regarding the :term:`BBPATH` variable and the
> -    ``conf/bblayers.conf`` file is relevant.
> +
> +
> +


Why are you adding 3 empty lines here?

>   
>       When you run BitBake, it begins looking for metadata files. The
>       :term:`BBPATH` variable is what tells BitBake where
> @@ -254,17 +242,6 @@ Following is the complete "Hello World" example.


Wait, before this, it seems you forgot to update the output of the 
"bitbake" command right after setting the BBPATH variable. Or maybe you 
didn't work with the "master" branch. Here's what I get when I use 
bitbake from the current Poky master branch:

$bitbake
Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake 
--help' for usage information.

Unless there's something in my environment that makes BitBake behave 
differently, but that's worth double checking anyway.

>       exists, you can run the ``bitbake`` command again::
>   
>          $ bitbake
> -       ERROR: Traceback (most recent call last):
> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
> -           return func(fn, *args)
> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 177, in _inherit
> -           bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 92, in inherit
> -           include(fn, file, lineno, d, "inherit")
> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 100, in include
> -           raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
> -       ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
> -
>          ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
>   
>       In the sample output,


Same here. At this stage on Poky master, I get:
$bitbake
Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake 
--help' for usage information.

> @@ -284,7 +261,10 @@ Following is the complete "Hello World" example.
>         $ mkdir classes
>   
>       Move to the ``classes`` directory and then create the
> -    ``base.bbclass`` file by inserting this single line: addtask build
> +    ``base.bbclass`` file by inserting this single line::
> +
> +      addtask build
> +
>       The minimal task that BitBake runs is the ``do_build`` task. This is
>       all the example needs in order to build the project. Of course, the
>       ``base.bbclass`` can have much more depending on which build


Good catch. This is ugly in the current docs.

> @@ -328,10 +308,11 @@ Following is the complete "Hello World" example.
>         BBFILES += "${LAYERDIR}/*.bb"
>         BBFILE_COLLECTIONS += "mylayer"
>         BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
> +      LAYERSERIES_COMPAT_mylayer = "dunfell"

You may mention that "dunfell" is just an example, and should be adapted 
to the OpenEmbedded-Core version(s) that your layer supports. By the 
way, "kirkstone" should be a better choice as it should last longer than 
"dunfell".

By the way, wishing we had a DISTRO_NAME_NO_CAP macro like in the YP 
manual, but that's will be a separate topic.

>   
>       For information on these variables, click on :term:`BBFILES`,
> -    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS` or :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
> -    to go to the definitions in the glossary.
> +    :term:`LAYERDIR`, :term:`BBFILE_COLLECTIONS`, :term:`BBFILE_PATTERN_mylayer <BBFILE_PATTERN>`
> +    or :term:`LAYERSERIES_COMPAT` to go to the definitions in the glossary.
>   
>       You need to create the recipe file next. Inside your layer at the
>       top-level, use an editor and create a recipe file named
> @@ -389,12 +370,14 @@ Following is the complete "Hello World" example.


Before this too, I don't have the same output when I run "bitbake 
printhello" for the first time:

$ bitbake printhello
ERROR: Nothing PROVIDES 'printhello'

>       target::
>   
>          $ bitbake printhello
> +       Loading cache: 100% |
> +       Loaded 0 entries from dependency cache.
>          Parsing recipes: 100% |##################################################################################|
> -       Time: 00:00:00
>          Parsing of 1 .bb files complete (0 cached, 1 parsed). 1 targets, 0 skipped, 0 masked, 0 errors.
>          NOTE: Resolving any missing task queue dependencies
> -       NOTE: Preparing RunQueue
> -       NOTE: Executing RunQueue Tasks
> +       Initialising tasks: 100% |###############################################################################|
> +       NOTE: No setscene tasks
> +       NOTE: Executing Tasks
>          ********************
>          *                  *
>          *  Hello, World!   *


Weird, I believe I followed the instructions correctly, but I still have:
ERROR: Nothing PROVIDES 'printhello'

This will probably help to know which version of Bitbake you're using. 
For documentation in "master", you should be using "master" too.

Sorry for all this changes, but it's great to fix an outdated version. 
If you lack time, I'll be happy to suggest a V2 that you could review 
then. Let me know...

Thanks again
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


