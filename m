Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532CC433F5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 21:07:42 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.19600.1643231261736279304
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jan 2022 13:07:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=FaprR5TR;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id b9so1333282lfq.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Jan 2022 13:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=CxVcR+yBvOrH+yKZYhGSyF5X1jY1IbgKzAxXqi+sB80=;
        b=FaprR5TRBfwHzmZc2kuoutDJdQHIRG0zLDYbgrvBg27PW4+LuMppqrZDGxWmX/xfjr
         WA1D6gdQTYruBzhhkgnUXsgzOIa57CaF2lKpwGp34G+1TJ/9ehThqAuC7gl/Y8/4rP8G
         E+0hsrFF0g6SdPQzutPn7ycFwSaUrB/9z+GFLRdXNvvXlkhpZTOmYzM5bmzAmWEYgnAx
         RNDaJQ/OCsOH4+sfYywzs2KNWGypluKa4/NW6eUPJSprFgLIEfPQASG4dHz89E475HIF
         CcoRCfHd+j2yI6ZA2urFZIVqd2yuWiygG3X7PHKZPhlRmjZX9k4OEPRscaE4hMJq4iI3
         IhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CxVcR+yBvOrH+yKZYhGSyF5X1jY1IbgKzAxXqi+sB80=;
        b=O2Vgik2nHz1bPBSRZR4LtSy5VVAK2aZHpAXis6NELqxdkO1yoZUob1jjnSFneZKalD
         Yy5zUyzbjB7jm8fN2bNMGunGJlvmX4hZPo/FPoFHRUa/Yk0obrQcElsXMLgVS1P3NF5I
         enJY/iX4GLt4ziGZFs+QHLzdzm4FzAi7OyW8cUacD1oIHg0+M/cExM5ZRwXNSYfe72z2
         qwKarAhWjnxukzvQRGX3l4CdYKTcjfAPa9/9z7PviIDskKf6hIgj/0r5Fs9O5lRB8YeG
         pJVxZzDVnYKMBBOPZkaojAQV3XyEwuCOnVSgfVP1nNNuR5q59qzudirMV9FaigeoWPdW
         l78w==
X-Gm-Message-State: AOAM531DtyrAl/SLUujVZmPLTHylulzzms10YTdNjI6e3tNnn6SRUUGi
	7BrVKBxfhESRMOGem3pis75FsgTH9w==
X-Google-Smtp-Source: 
 ABdhPJy/rM00oc1ebOyIHLAYPCFT6rw9BblYeFRQiA+9REsLUL/fvXtJvqgju6hziD/uBrlHq/1j2g==
X-Received: by 2002:ac2:523c:: with SMTP id i28mr619859lfl.156.1643231259979;
        Wed, 26 Jan 2022 13:07:39 -0800 (PST)
Received: from [192.168.1.248]
 (031011128254.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.254])
        by smtp.gmail.com with ESMTPSA id
 z19sm1806030lfg.126.2022.01.26.13.07.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 13:07:39 -0800 (PST)
Message-ID: <7c42ded1-91e0-b6f2-ba1a-7c20635c6311@gmail.com>
Date: Wed, 26 Jan 2022 22:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] checksum: Support uri formatted file list
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <20220126210417.466199-1-ptsneves@gmail.com>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: <20220126210417.466199-1-ptsneves@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jan 2022 21:07:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13286

This patch contains a new test which shows the spaces in the license 
file name are now working. Unfortunately the file:// in SRC_URI with 
spaces still fail. I am working on that although I would any comments in 
the mean time.

Paulo Neves

On 1/26/22 22:04, Paulo Neves wrote:
> Before this commit, if the file list for checksumming had
> files names with spaces there would be a crash. This happened
> due to filelist.split breaking on the file names instead of
> on k:v boundaries. Now we validate this case and emit a fatal
> error if such case is found. This needs to be fatal as the split
> will generate broken k:v from then on.
>
> Instead of putting literal spaces in the file list the user
> should urlencode the file names and if they contain coded spaces
> they will be decoded. This is consistent with the current
> practice where file names are urlencoded. A reproducer of the
> issue this commit fixes, was to pass a do_compile[file-checksums]
> list with files containing spaces in their names, urlencoded or
> literal.
>
> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>   bitbake/lib/bb/checksum.py                   |  9 +++++++--
>   bitbake/lib/bb/fetch2/__init__.py            |  6 +++---
>   meta/classes/base.bbclass                    |  4 +++-
>   meta/lib/oeqa/selftest/cases/lic_checksum.py | 18 ++++++++++++++++++
>   4 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
> index fb8a77f6ab..4d34baffcc 100644
> --- a/bitbake/lib/bb/checksum.py
> +++ b/bitbake/lib/bb/checksum.py
> @@ -8,6 +8,7 @@
>   import glob
>   import operator
>   import os
> +import urllib
>   import stat
>   import bb.utils
>   import logging
> @@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
>   
>           checksums = []
>           for pth in filelist.split():
> -            exist = pth.split(":")[1]
> +            spl = pth.split(':')
> +            if len(spl) != 2:
> +                bb.fatal("found unformatted path in filelist " + pth)
> +
> +            exist = spl[1]
>               if exist == "False":
>                   continue
> -            pth = pth.split(":")[0]
> +            pth = urllib.parse.unquote(spl[0])
>               if '*' in pth:
>                   # Handle globs
>                   for f in glob.glob(pth):
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index d37174185a..c19d4b8636 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -1214,13 +1214,13 @@ def get_checksum_file_list(d):
>               paths = ud.method.localpaths(ud, d)
>               for f in paths:
>                   pth = ud.decodedurl
> -                if f.startswith(dl_dir):
> +                if pth.startswith(dl_dir):
>                       # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
> -                    if os.path.exists(f):
> +                    if os.path.exists(pth):
>                           bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN'), os.path.basename(f)))
>                       else:
>                           bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
> -                filelist.append(f + ":" + str(os.path.exists(f)))
> +                filelist.append(f + ":" + str(os.path.exists(pth)))
>   
>       return " ".join(filelist)
>   
> diff --git a/meta/classes/base.bbclass b/meta/classes/base.bbclass
> index 5f4956a1d3..8e6cf84479 100644
> --- a/meta/classes/base.bbclass
> +++ b/meta/classes/base.bbclass
> @@ -94,6 +94,8 @@ def extra_path_elements(d):
>   PATH:prepend = "${@extra_path_elements(d)}"
>   
>   def get_lic_checksum_file_list(d):
> +    import urllib
> +
>       filelist = []
>       lic_files = d.getVar("LIC_FILES_CHKSUM") or ''
>       tmpdir = d.getVar("TMPDIR")
> @@ -113,7 +115,7 @@ def get_lic_checksum_file_list(d):
>               if path[0] == '/':
>                   if path.startswith((tmpdir, s, b, workdir)):
>                       continue
> -                filelist.append(path + ":" + str(os.path.exists(path)))
> +                filelist.append(urllib.parse.quote(path) + ":" + str(os.path.exists(path)))
>           except bb.fetch.MalformedUrl:
>               bb.fatal(d.getVar('PN') + ": LIC_FILES_CHKSUM contains an invalid URL: " + url)
>       return " ".join(filelist)
> diff --git a/meta/lib/oeqa/selftest/cases/lic_checksum.py b/meta/lib/oeqa/selftest/cases/lic_checksum.py
> index 91021ac335..6bdbac3ba2 100644
> --- a/meta/lib/oeqa/selftest/cases/lic_checksum.py
> +++ b/meta/lib/oeqa/selftest/cases/lic_checksum.py
> @@ -4,6 +4,7 @@
>   
>   import os
>   import tempfile
> +import urllib
>   
>   from oeqa.selftest.case import OESelftestTestCase
>   from oeqa.utils.commands import bitbake
> @@ -11,6 +12,23 @@ from oeqa.utils import CommandError
>   
>   class LicenseTests(OESelftestTestCase):
>   
> +    def test_checksum_with_space(self):
> +        bitbake_cmd = '-c populate_lic emptytest'
> +
> +        lic_file, lic_path = tempfile.mkstemp(" -afterspace")
> +        os.close(lic_file)
> +        #self.track_for_cleanup(lic_path)
> +
> +        self.write_config("INHERIT:remove = \"report-error\"")
> +
> +        self.write_recipeinc('emptytest', """
> +INHIBIT_DEFAULT_DEPS = "1"
> +LIC_FILES_CHKSUM = "file://%s;md5=d41d8cd98f00b204e9800998ecf8427e"
> +SRC_URI = "file://%s;md5=d41d8cd98f00b204e9800998ecf8427e"
> +""" % (urllib.parse.quote(lic_path), urllib.parse.quote(lic_path)))
> +        result = bitbake(bitbake_cmd)
> +
> +
>       # Verify that changing a license file that has an absolute path causes
>       # the license qa to fail due to a mismatched md5sum.
>       def test_nonmatching_checksum(self):


