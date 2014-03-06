Return-Path: <krirobo@gmail.com>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
	[209.85.220.176])
	by mail.openembedded.org (Postfix) with ESMTP id 4C1196E77A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Mar 2014 20:41:34 +0000 (UTC)
Received: by mail-vc0-f176.google.com with SMTP id lc6so2663796vcb.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Mar 2014 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=Fh4ByNfKvMxlk4K30z1iQNHrByxnn6OQvLvn6N5/xHg=;
	b=oP6kkP3e7iVb0PrMaVzohKfcvddW4Gn7DwRdef/+0oSq47L8C8hLomPYGvoFeQbrgG
	UFLpgBEyfECmZmG35aTuptmu/zFJXACK2/fXlzCpMV49zKXFXlFon2qRUCciqOtL1rKM
	Xher0QwjqhyvvvA5zJl6IBaCJOSTew0Dv54GWpsJwNZWCdxLHCnB9cfYN6qzCfxv9s5h
	XeOQ+HuVwVElZ7DtToU61KtTEFoJeId4AJU2CCbpKKyzJ7wRBuOOWq5kWQ84G5iroVMt
	wzVV5ZljQuNr646TkXO5VUZ6rSiOpjVDV7TtNHok7qmGXk/Fehx1XSn8J7gViQucULcd
	W57A==
MIME-Version: 1.0
X-Received: by 10.220.136.6 with SMTP id p6mr6723274vct.9.1394138495400; Thu,
	06 Mar 2014 12:41:35 -0800 (PST)
Received: by 10.58.133.233 with HTTP; Thu, 6 Mar 2014 12:41:35 -0800 (PST)
Date: Thu, 6 Mar 2014 21:41:35 +0100
Message-ID: <CAFgGSN6AaG6ZPPUmJzqiJeYXDK1mKyG=i8vH6q=u8E63fPT6OQ@mail.gmail.com>
From: Kristof Robot <krirobo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch/wget: Start to clean up command construction
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
X-List-Received-Date: Thu, 06 Mar 2014 20:41:39 -0000
Content-Type: text/plain; charset=ISO-8859-1

>Start to clean up wget fetcher command construction to allow clearer
>and more extensible code structure. Drops support for ${URI} and
>${FILE} directly in the commands.
>
>Signed-off-by: Richard Purdie <richard.purdie at linuxfoundation.org>
>[...]
>         if not checkonly and 'downloadfilename' in ud.parm:
>             dldir = d.getVar("DL_DIR", True)
>             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
>-            basecmd += " -O " + dldir + os.sep + ud.localfile
>+            fetchcmd += " -O " + dldir + os.sep + ud.localfile
>
>+        uri = ud.url.split(";")[0]
>         if checkonly:
>-            fetchcmd = d.expand(basecmd + " --spider '${URI}'")
>+            fetchcmd = self.basecmd + " --spider '%s'" % uri
>         elif os.path.exists(ud.localpath):
>             # file exists, but we didnt complete it.. trying again..
>-            fetchcmd = d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
>+            fetchcmd = self.basecmd + d.expand(" -c -P ${DL_DIR} '%s'" % uri)
>         else:
>-            fetchcmd = d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
>-

This patch breaks the "downloadfilename" functionality, as the
fetchcmd append in the first if structure will be overwritten by the
fetchcmd assignments in the second if structure, effectively losing
the appended information.

As a quick fix, I replaced

 fetchcmd += " -O " + dldir + os.sep + ud.localfile

by

 self.basecmd += " -O " + dldir + os.sep + ud.localfile

but there might be a better way of resolving this?

Kristof

