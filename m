Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5099.1631219422811746161
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Sep 2021 13:30:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CvAMI24Z;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id q26so4302679wrc.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Sep 2021 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a4xA2s3C+L5gCgAWYxZsoh4pPVXU9XPaDnyzvuDdUCU=;
        b=CvAMI24ZhcnudSVICxLg5FFhaPyqYsXyuERKCDBvF/1Z93KsJwCScy1alrh5H+PXLu
         7s+JfS3YV30p4eYX2IKSDFtUfscmnCZ2/2AcjlNPU3kUz3OCQ3UyJ40sHWr61LUpWs5E
         0z7qvRGsA3eBic3Hl/W97tOzGxtALfFcvoCGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4xA2s3C+L5gCgAWYxZsoh4pPVXU9XPaDnyzvuDdUCU=;
        b=ogt4BtD8xMNABm8B6u2xI9UmAIY+qKVRNepTRhxs0JJJyRXtFnunmBf4xRjf4W5ZqP
         GEoShmTliq+yeK3MaI3kwRNa36wdlbVAdnOwLNbmYSH6PH0jzS+EvqhBbetLFpGNuPeU
         7NL7uvemJglQzmWLkM8f4L2wyGFSueFYOBj4rtsot/BK6lgD+waNHVgDn8oIm3+aw1jC
         CufQWnKhp60/g7A3B87VuQ6edf3CSr5zl3GN3xTGzvm250Wljbl1FB/u3yPlD9wxcJVB
         xOMsWuLmHGCqXED9Irsgt0rgkCzNZ2Di02xVKepvFKzSR/5MbFXA+Ot5jdW241B8xXon
         D6LA==
X-Gm-Message-State: AOAM533+6s+DDqguAsaGweNqblZLpqVW/ogOPfsn1mbPUVDH3Em9gS/p
	rxz6FuiSvq9j4WZBllAQkmnEvh+r6AW0yMzM
X-Google-Smtp-Source: ABdhPJz/jP7QUHsoKbRhy61J4BlDtJ4RA6k0Y1L2mFnLBcErrcJh5mM/TxyhgGLjDVlWvdbs1ir6hw==
X-Received: by 2002:a5d:61d2:: with SMTP id q18mr4244531wrv.191.1631219420948;
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id t64sm2344002wma.48.2021.09.09.13.30.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] bin: Drop unused warnings import
Date: Thu,  9 Sep 2021 21:30:19 +0100
Message-Id: <20210909203019.1231314-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
References: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop some unused module imports.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-diffsigs | 1 -
 bin/bitbake-server   | 1 -
 bin/bitbake-worker   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 19420a2df6..2786ecd673 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -10,7 +10,6 @@
 
 import os
 import sys
-import warnings
 import argparse
 import logging
 import pickle
diff --git a/bin/bitbake-server b/bin/bitbake-server
index 8e53947361..b5d275b70e 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -7,7 +7,6 @@
 
 import os
 import sys
-import warnings
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 7d982f90ba..a9e33ca7c7 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -5,7 +5,6 @@
 
 import os
 import sys
-import warnings
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 from bb import fetch2
 import logging
-- 
2.32.0

