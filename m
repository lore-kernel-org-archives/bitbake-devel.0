Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACFEC433F5
	for <webhook@archiver.kernel.org>; Sun,  6 Feb 2022 13:50:29 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web08.8734.1644155428447695334
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Feb 2022 05:50:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=k+tfuyWO;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id u14so21924018lfo.11
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Feb 2022 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=42RLLca648Rd49IPiJOM9Rma1Q/DbEF/ZVcQO+x/Wnw=;
        b=k+tfuyWOYZlKzVwtIiaMKUILZtMtMdM4LzZG1sWUTAXwOv8w9tGQmVJL0EjjcpXmjh
         SUuxL8GS3HZgW9uyupLkL4pI6gBuuK2CNyVN4yKx6cCYs3+XV60aVqiMbACtI28NKiud
         hMI8ofJk7EvpPUwRdQ2I+9t/GS77U2xWQ+YkRK9mT/LDELKo3L0ydQ7u0JSz3GJaByWs
         7igwUHM+ZaH7N8uVuEwrpqJYAwYx4GZK9Y1D9neypvsmPZBaHRmYxcF7mL1XY73udn5m
         Q2sWnnJuQVqxjqwTDzi85vzkd6f005aljN5ox6OYwPElV1wsikeO4mktPqt+NP9ibAXi
         KBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=42RLLca648Rd49IPiJOM9Rma1Q/DbEF/ZVcQO+x/Wnw=;
        b=PwwbAGRz5Jfe7dRn0lgPt9akcz1SNgRealojzRCePCl9WaCr5T0DA9qIo/bqodMWlt
         cKrC/wkjwXwqvc7ksEqsQ34UJcWZrhArijG3KhPZSKkQ+kYNYk1FhFCIDI4WQUTOinXB
         ydW2NVEpfu+NE9VtZBnsLLtlkbRCizC3mJbhK2lLZz85MmaCPGMwf8s9kksJJfW4LowC
         4/90wgfBuleBoe9OMJ78ylvAdT/D3tO6Xs9WGfyTH4ayOk2RiHwZAWn1RuPaHf6M+xjS
         XQqnLEED4luO1Vgx0HfntkSZv/5J93mGHsQ2avX4b95jR4NahbbTx0Zgn0c9eO9bJ1Jm
         ZL3g==
X-Gm-Message-State: AOAM530ZlQR9kLxChvx1hpgetZJRYAVB29L7rh+68ghytf5AuNiYp+/m
	BEK4Fm/CSF4t91YF+3wvrLUwXoPkhA==
X-Google-Smtp-Source: 
 ABdhPJz9ks/dZg5dUv3i48H/TDpRMHbcC4iR/B+yQ/1OG7Gppt35vI0v6W3L0eYyVeQtZd0YNyuFBA==
X-Received: by 2002:a05:6512:3052:: with SMTP id
 b18mr5427900lfb.5.1644155426464;
        Sun, 06 Feb 2022 05:50:26 -0800 (PST)
Received: from [192.168.1.248]
 (031011128254.dynamic-3-poz-k-0-2-0.vectranet.pl. [31.11.128.254])
        by smtp.gmail.com with ESMTPSA id
 y13sm229711ljn.79.2022.02.06.05.50.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 05:50:26 -0800 (PST)
Message-ID: <fa768d32-b6d6-7298-05bd-91639ad3e66d@gmail.com>
Date: Sun, 6 Feb 2022 14:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] checksum: Support uri formatted file list
Content-Language: en-US
To: bitbake-devel@lists.openembedded.org
References: <20220206134507.123558-1-ptsneves@gmail.com>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: <20220206134507.123558-1-ptsneves@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Feb 2022 13:50:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13314

The current patch passes the newly created test: both on the SRC_URI as 
well as LIC_FILES_CHKSUM. Let me know if there is anything else needed 
for a merge :)


Paulo Neves
On 2/6/22 14:45, Paulo Neves wrote:
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
> index d37174185a..5cdd150d6b 100644
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
> +                filelist.append(urllib.parse.quote(f) + ":" + str(os.path.exists(pth)))
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


