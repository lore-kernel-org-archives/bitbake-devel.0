Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.3352.1631823770946353867
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=EI6FfNGB;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id i23so11460188wrb.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3O6nLqn+crHx1QLC5NgSU184pb0v+1NU0ecglz2slk=;
        b=EI6FfNGBxSf99uvHqUE01/3EMsdIoTcthzkjMozpAdSvtjPE31RQZW/BOU8ZG3MUgn
         G1e67xOV1pBaTRcEsLAoA8jjbZ7qNdFxRh4S/INQWF2i2+YyC+wob8iiuMUJctdIu6Ya
         q3qfN5qxPPClPyXVljcGuWiWQNuHMsxW0J8tyVqRnBgIrulXzFWlQKGypzbhTDTGPaOU
         3HsxpG2FDiUB6L1uO3nh3+l4fAv8ol40u2nyQGA5YQnHQrPcUMudfAglGaceEyDdO1Q4
         rQLCpdSZcdvohCqA9gEYpCMab6x2pYMkQ+75c5Co3+ONKlcfie38d+6mBhiYJadRVmuy
         AOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3O6nLqn+crHx1QLC5NgSU184pb0v+1NU0ecglz2slk=;
        b=OIiKWknMHT8+b2JDEV9WKWOh8MGh51xCWYMKMrVgYRm6+TtVbwRO3gV41rKQ/lqQGd
         iEB73rj9fJvLiituzq8Z6z7MqOYZbh+n6ahHWXz9iMpH+cMdkbjGbZ771MblMC4/ep1Z
         qbEX3G0XHgyo/SQYORqMJ62NrXeUxSvBabm2N7AlqlpazkoM3Eu6D4/+9i/7lLJf7bT/
         8JvwOAD2m/caSqYaf8kGpXcZ1PS/Jut+urXeMjZtjjSECm7EAFrVmO/R5edmaSWO2yha
         VV67bHaWNhObwaJuuiVh15X5g1+qWFcABphgzz+wahyxKM5OxpQhG/WJ4ok3KhxW1Fql
         wSgg==
X-Gm-Message-State: AOAM531L840FNZs2Xx0a4DnBv0jDrT7cQM4GIydLwQuk2yTcAMaTzjdp
	MHKCOQpU8CPSm0DXwIgPJ6XXK6CD4U4=
X-Google-Smtp-Source: ABdhPJwzumLC5K/To42TT+dsnmOMCUmb3exOHOOSqeBPzlBJX0Ntn7msY8sJIVcPURTA8RYBtjpcSw==
X-Received: by 2002:a5d:448d:: with SMTP id j13mr8029645wrq.212.1631823769391;
        Thu, 16 Sep 2021 13:22:49 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:48 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/7] bitbake: enable python warnings at the first opportunity
Date: Thu, 16 Sep 2021 22:22:31 +0200
Message-Id: <20210916202237.1929584-1-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We really do want to see those, as they tend to turn into
hard errors eventually, as what happened with collections
vs collections.abc in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/bin/bitbake             | 2 ++
 bitbake/bin/bitbake-diffsigs    | 1 +
 bitbake/bin/bitbake-getvar      | 2 ++
 bitbake/bin/bitbake-hashclient  | 2 ++
 bitbake/bin/bitbake-hashserv    | 2 ++
 bitbake/bin/bitbake-layers      | 2 ++
 bitbake/bin/bitbake-prserv      | 2 ++
 bitbake/bin/bitbake-selftest    | 2 ++
 bitbake/bin/bitbake-server      | 1 +
 bitbake/bin/bitbake-worker      | 1 +
 bitbake/bin/git-make-shallow    | 2 ++
 bitbake/bin/toaster-eventreplay | 2 ++
 12 files changed, 21 insertions(+)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index dc1873af69c..d3ee8e9464b 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -12,6 +12,8 @@
 
 import os
 import sys
+import warnings
+warnings.simplefilter("default")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))
diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 19420a2df69..6646dccdfa2 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -11,6 +11,7 @@
 import os
 import sys
 import warnings
+warnings.simplefilter("default")
 import argparse
 import logging
 import pickle
diff --git a/bitbake/bin/bitbake-getvar b/bitbake/bin/bitbake-getvar
index 94232192531..5435a8d7978 100755
--- a/bitbake/bin/bitbake-getvar
+++ b/bitbake/bin/bitbake-getvar
@@ -9,6 +9,8 @@ import argparse
 import io
 import os
 import sys
+import warnings
+warnings.simplefilter("default")
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index a89290217b0..494f17592ac 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -13,6 +13,8 @@ import pprint
 import sys
 import threading
 import time
+import warnings
+warnings.simplefilter("default")
 
 try:
     import tqdm
diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
index 153f65a3787..00af76b2d11 100755
--- a/bitbake/bin/bitbake-hashserv
+++ b/bitbake/bin/bitbake-hashserv
@@ -10,6 +10,8 @@ import sys
 import logging
 import argparse
 import sqlite3
+import warnings
+warnings.simplefilter("default")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
 
diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index ff085d67442..449434d468e 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -14,6 +14,8 @@ import logging
 import os
 import sys
 import argparse
+import warnings
+warnings.simplefilter("default")
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)
diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
index bef5ef68978..323df66dd06 100755
--- a/bitbake/bin/bitbake-prserv
+++ b/bitbake/bin/bitbake-prserv
@@ -6,6 +6,8 @@
 import os
 import sys,logging
 import optparse
+import warnings
+warnings.simplefilter("default")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),'lib'))
 
diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index aec47069216..f25f23b1ae7 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -7,6 +7,8 @@
 
 import os
 import sys, logging
+import warnings
+warnings.simplefilter("default")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
 
 import unittest
diff --git a/bitbake/bin/bitbake-server b/bitbake/bin/bitbake-server
index 8e539473614..f53f88b6b0d 100755
--- a/bitbake/bin/bitbake-server
+++ b/bitbake/bin/bitbake-server
@@ -8,6 +8,7 @@
 import os
 import sys
 import warnings
+warnings.simplefilter("default")
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 3ca8c1853bb..6ead2da6d1e 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -6,6 +6,7 @@
 import os
 import sys
 import warnings
+warnings.simplefilter("default")
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 from bb import fetch2
 import logging
diff --git a/bitbake/bin/git-make-shallow b/bitbake/bin/git-make-shallow
index 57069f7edf7..1d00fbf1838 100755
--- a/bitbake/bin/git-make-shallow
+++ b/bitbake/bin/git-make-shallow
@@ -16,6 +16,8 @@ import itertools
 import os
 import subprocess
 import sys
+import warnings
+warnings.simplefilter("default")
 
 version = 1.0
 
diff --git a/bitbake/bin/toaster-eventreplay b/bitbake/bin/toaster-eventreplay
index 8fa4ab7116b..404b61f5162 100755
--- a/bitbake/bin/toaster-eventreplay
+++ b/bitbake/bin/toaster-eventreplay
@@ -19,6 +19,8 @@ import sys
 import json
 import pickle
 import codecs
+import warnings
+warnings.simplefilter("default")
 
 from collections import namedtuple
 
-- 
2.20.1

