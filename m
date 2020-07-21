Received: from mx1.tq-group.com (mx1.tq-group.com [62.157.118.193])
 by mx.groups.io with SMTP id smtpd.web12.15154.1595322208253928735
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2020 02:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@tq-group.com header.s=key1 header.b=aoAbAP4+;
 spf=none, err=permanent DNS error (domain: ew.tq-group.com, ip: 62.157.118.193, mailfrom: matthias.schiffer@ew.tq-group.com)
IronPort-SDR: kA7HQzzZ+lhSlu+63+sOA1VNZp/uYQi3JZ3EVi3peugs3BHYH6yJV1UfL8U5sx6GaCdJ60JfMf
 hF1dE43Wjr5QpEWqLVHCA7dUAOoaODHR4sLSd+Z6yJDcAmj+hnhrnIAqPmx3daBGZ3CoHkd6xO
 riDGT785X+MpkNLw96Apq77anUABE3be5k6sfYkc/CRGyGA2160pJhkaD+IWRTi1hCSlYoApur
 2CHwg+/UZimpKf70BgTxgaSCcUa3GL+Q01sZzulW1fkzfjQgYZVjh7DxIiXPg/mtlN2GbAxwa6
 sKQ=
X-IronPort-AV: E=Sophos;i="5.75,378,1589234400"; 
   d="scan'208";a="13177796"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Jul 2020 11:03:24 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 21 Jul 2020 11:03:24 +0200
X-PGP-Universal: processed;
	by tq-pgp-pr1.tq-net.de on Tue, 21 Jul 2020 11:03:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1595322204; x=1626858204;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWMqeVpqA5eeidMqmDZSHJGKPgNcDq5YCbJ0zOdV5LA=;
  b=aoAbAP4+KD9zCYE3IzSrcHOI4CkdJ+P+wnfZWserSQjWLGA82/YbZQc1
   zqX4u13eCUw0X9i6EPbigUjFh52UX8QFrOnc+KCVW59ojcDW395pplDSk
   JDxZVicLnKhNCO+p5fj9icsTMNIs0MqpHr9GYwTbsygmmo59QIn0T9ZqR
   FTxz+irOrFr/Pd5Rcpt0Tc2JwBFMETQwhJQMM6pofPIn4oYNbwBXQXjmT
   QyLvFbWqx+/uDMP1b873sIn3YaYPZhLNnW7RvpXwnf9OzJJbbQj4N+irq
   NRRqTmTlqSfp2XZfz9DnS/6bxxDOJv3ULliG08ZNMsgcJtOG5wL5Q8rCK
   A==;
IronPort-SDR: 6vUyfqxpMwiekbgviK1sBU27IvAi/Ah8GOHgBsqxOPz9N2MKZB4n+ZYZg369+BAovcdroV3o9W
 SJQz9qihis6xZl0vLN+LOMwphLoZK9Q//3OcW7OS/NXTrVuE7c3iq/fs4koo+US1wJUIIIthsg
 RQ9IkEvRzvjn6bZpalv0KMYWXUSH8TpyOOXqkKOLHLmSfhH5KJs2Pjd9hMW3XPtX6AKwM+okr6
 W8bikvxJKwcf0sOaCo5P9NCRPG0UkKD0ALt/CKx3H5/ybDWxmXJarHukSYZbOGzzenK8LbvF0D
 7b8=
X-IronPort-AV: E=Sophos;i="5.75,378,1589234400"; 
   d="scan'208";a="13177795"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2020 11:03:24 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4A56F280065;
	Tue, 21 Jul 2020 11:03:24 +0200 (CEST)
Message-ID: <bff2188dac00483453538fa132e5c289cbfdb9ca.camel@ew.tq-group.com>
Subject: Re: (EXT) [bitbake-devel] [PATCH v2] fetch2/gitsm: Unpack shallow mirror	tarballs
From: "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>
To: Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Jul 2020 11:03:22 +0200
In-Reply-To: <20200309134246.14067-1-pbarker@konsulko.com>
References: <20200309134246.14067-1-pbarker@konsulko.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-03-09 at 13:42 +0000, Paul Barker wrote:
> When a shallow mirror tarball is used to satisfy a gitsm URI it needs
> to
> be unpacked temporarily so that the .gitmodules file can be examined.
> 
> Signed-off-by: Paul Barker <pbarker@konsulko.com>

Hi,

can we get this backported to the 1.44 branch?

Kind regards,
Matthias



> ---
>  lib/bb/fetch2/gitsm.py | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index aa121cbe..e7083001 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -20,6 +20,8 @@ NOTE: Switching a SRC_URI from "git://" to
> "gitsm://" requires a clean of your r
>  import os
>  import bb
>  import copy
> +import shutil
> +import tempfile
>  from   bb.fetch2.git import Git
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> @@ -130,7 +132,7 @@ class GitSM(Git):
>              ld.setVar('SRCPV', d.getVar('SRCPV'))
>              ld.setVar('SRCREV_FORMAT', module)
>  
> -            function(ud, url, module, paths[module], ld)
> +            function(ud, url, module, paths[module], workdir, ld)
>  
>          return submodules != []
>  
> @@ -152,7 +154,7 @@ class GitSM(Git):
>          return False
>  
>      def download(self, ud, d):
> -        def download_submodule(ud, url, module, modpath, d):
> +        def download_submodule(ud, url, module, modpath, workdir,
> d):
>              url += ";bareclone=1;nobranch=1"
>  
>              # Is the following still needed?
> @@ -163,16 +165,25 @@ class GitSM(Git):
>                  newfetch.download()
>                  # Drop a nugget to add each of the srcrevs we've
> fetched (used by need_update)
>                  runfetchcmd("%s config --add bitbake.srcrev %s" % \
> -                            (ud.basecmd, ud.revisions[ud.names[0]]),
> d, workdir=ud.clonedir)
> +                            (ud.basecmd, ud.revisions[ud.names[0]]),
> d, workdir=workdir)
>              except Exception as e:
>                  logger.error('gitsm: submodule download failed: %s
> %s' % (type(e).__name__, str(e)))
>                  raise
>  
>          Git.download(self, ud, d)
> -        self.process_submodules(ud, ud.clonedir, download_submodule,
> d)
> +
> +        # If we're using a shallow mirror tarball it needs to be
> unpacked
> +        # temporarily so that we can examine the .gitmodules file
> +        if ud.shallow and os.path.exists(ud.fullshallow) and
> self.need_update(ud, d):
> +            tmpdir = tempfile.mkdtemp(dir=d.getVar("DL_DIR"))
> +            runfetchcmd("tar -xzf %s" % ud.fullshallow, d,
> workdir=tmpdir)
> +            self.process_submodules(ud, tmpdir, download_submodule,
> d)
> +            shutil.rmtree(tmpdir)
> +        else:
> +            self.process_submodules(ud, ud.clonedir,
> download_submodule, d)
>  
>      def unpack(self, ud, destdir, d):
> -        def unpack_submodules(ud, url, module, modpath, d):
> +        def unpack_submodules(ud, url, module, modpath, workdir, d):
>              url += ";bareclone=1;nobranch=1"
>  
>              # Figure out where we clone over the bare submodules...
> -- 
> 2.20.1
> 

