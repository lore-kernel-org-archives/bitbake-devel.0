Return-Path: <corentin.guillevic@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B514D77894
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 17:24:29 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.638.1769189065828635128
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 09:24:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=BCDwyL6c;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: corentin.guillevic@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d256c2e6so2441305f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 09:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769189064; x=1769793864; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xm54axmZs6Nu+gHr8KU8YKNMYPzbdMTOLQf1ZfsH4w=;
        b=BCDwyL6ccMG8cOiN/gyihzJf4RixSGwsFrVBTRAlIbh7roqVNMotKr8hcCqfABC5gj
         TY2pRwerRpZY5zgdeX5fY+FZTDtgYADFiIzmYn5z6Zy2EnlVej1oMUkNDDQ3vs19wUqO
         9LsE2aKyZSkadaXFK23OlWr0T7PH2BawEZpLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769189064; x=1769793864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Xm54axmZs6Nu+gHr8KU8YKNMYPzbdMTOLQf1ZfsH4w=;
        b=BdfkRCN+xupNYluNT578wU9I+P7Ann1R4Fle9foMLRAYq+QbDpo3MsyhCui42Ipobi
         YGj+AJDhZ5PZqBPzeGvakUeKmQQH6VqY1hOCgSPtPaCoDm5ouB+Ip0WrLtusD6RjiWVh
         n0z/4RaF0x29RDoFBK5am20wb3ZoRlZH6HlroHBAuqP6BYq9B7r4enDnsvoLt5YRF8b5
         MknwVydJz2RDzY8ErKLD7tGx6WQZhfyJ/6gt+6g85waLeiAcojLm3lXcJ2oTPYiaK7T5
         loLDwwu1gZfe9elwTfKQHcSjzxmaap90NoOeJ9R1vK6IJtdnBv/G30tYR/ZgYJBANOSq
         ruGA==
X-Gm-Message-State: AOJu0YwJ7t/mysvAymP6bb96d9rDAz8aLHCap+ne/NpaYIC6wuZQzrit
	yfXjRrRxSfKNC2opkzo4azp2iRyg7tTYr+tHyKMhHcgzNixEdX5MXEZ0GVNC7ORNG4CLWxnoCzV
	/wpuplp0=
X-Gm-Gg: AZuq6aImWhqczcObDtY4JCJj9LZ3mrbxPB1bQksYXerdaoM/Loy7IQPtpqe4gi4iqlZ
	Vg8+ttiJoCYvJxGz9JCKpTNMGI1sDEYeSLiWLDdGNxGqKLYi5h/+4aFMh3duwnI33MFNkGHl+1h
	F2k8RbaUJC/gvoP3ejc72e7IhBk8NRD/ODm409TCJx7jc5LrZIf0IcMgYeOR4jlFpS3/Xal41YI
	jtJ4eKk4sNwS9j24K9HYsH/WwqsoGE0dR42T5vA8O57ULgo3vya9YZqN68Oq3t7WNJ6Z5IphGyp
	yfMhgHX6vUeR7vj3NWb7ZGkLrsBPMj/OeSMmi2urS1gvvAnNjfHXizmWJoQFVftVH4KTthg1U4v
	zAjYzkpdRX4mNprdOffyXjs848E1/euXYYV6yRmQvO58DIONu+CAWVM/Bypaf/2tq1Ad3GDVMgx
	hH3Uasanfaqunwf22QcmDuWJXAvs0TzcYApIeucqRWrSTfLfoKPqrqEdIJPe7IE/aPWaGL7/xTN
	Nq5ekcoWqj9GpeW5aKBZchznkTVykA=
X-Received: by 2002:a05:6000:184f:b0:435:a287:82c with SMTP id ffacd0b85a97d-435b1589573mr6353033f8f.1.1769189064030;
        Fri, 23 Jan 2026 09:24:24 -0800 (PST)
Received: from heaven.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e715bfsm8664209f8f.22.2026.01.23.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:24:23 -0800 (PST)
From: Corentin Guillevic <corentin.guillevic@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Corentin Guillevic <corentin.guillevic@smile.fr>
Subject: [PATCH v6 1/4] bitbake-setup: add inline URI
Date: Fri, 23 Jan 2026 18:24:19 +0100
Message-ID: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 17:24:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18864

Most of the time, when we describe a remote, a bitbake-setup source looks like this:

"bitbake": {
    "git-remote": {
        "remotes": {
            "origin": {
                "uri": "https://git.openembedded.org/bitbake"
            }
        },
        ...
    }
}

i.e. an URI with the common name 'origin'. Alternatively, we could simplify this, by
using a shorter structure with the property 'uri' only:

"bitbake": {
    "git-remote": {
        "uri": "https://git.openembedded.org/bitbake",
        ...
    }
}

These properties can be used together.

Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
---

Notes:
    Changes in v6:
    - Port former structure under the description of the "remotes" property

 bin/bitbake-setup | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..f126b1560 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -104,14 +104,30 @@ def add_unique_timestamp_to_path(path):
                 break
     return path_unique
 
+def _get_remotes(r_remote):
+    remotes = []
+
+    if not 'remotes' in r_remote and not 'uri' in r_remote:
+        raise Exception("Expected key(s): 'remotes', 'uri'")
+
+    if 'remotes' in r_remote:
+        for remote in r_remote['remotes']:
+            remotes.append(r_remote['remotes'][remote]['uri'])
+
+    if 'uri' in r_remote:
+        remotes.append(r_remote['uri'])
+
+    return remotes
+
 def checkout_layers(layers, confdir, layerdir, d):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
-            prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            prot,host,path,user,pswd,params = bb.fetch.decodeurl(remote)
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             logger.plain("    {}".format(r_name))
             if branch:
@@ -658,10 +674,11 @@ def are_layers_changed(layers, layerdir, d):
         changed = False
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
-        remotes = r_remote['remotes']
+
+        remotes = _get_remotes(r_remote)
 
         for remote in remotes:
-            type,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
+            type,host,path,user,pswd,params = bb.fetch.decodeurl(remote)
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
             if branch:
                 fetcher = bb.fetch.FetchData("{};protocol={};rev={};branch={};destsuffix={}".format(fetchuri,type,rev,branch,repodir), d)
@@ -672,7 +689,7 @@ def are_layers_changed(layers, layerdir, d):
             local_revision = rev_parse_result[0].strip()
             if upstream_revision != local_revision:
                 changed = True
-                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remote, os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
         return changed
 
     changed = False
-- 
2.51.0


