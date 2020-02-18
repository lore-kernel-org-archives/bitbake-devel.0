Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail.openembedded.org (Postfix) with ESMTP id 745AA6152B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 15:45:35 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id n3so1070970wmk.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 07:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:user-agent:mime-version
	:content-transfer-encoding;
	bh=zC4Es4AB6jfXvjBqxGk8SS8EEBYUIZeiWIpWXmnSUGA=;
	b=Ok8sQO9y7qx8nZ5IRG1A8gXEqdc0jYAg3USR7rJmQqY3L9FQ7l9mDjytegqR79YSsi
	tTCRjFS/xj6wmLQSApi+HmqkwaMxlIfaKJQ1z9g6Ix42K+eVSnYRDpKEAyUEzUEEMVlF
	BOS63WIc1KvYhuXzHyHpxK1u+V9/27t3B73VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
	:mime-version:content-transfer-encoding;
	bh=zC4Es4AB6jfXvjBqxGk8SS8EEBYUIZeiWIpWXmnSUGA=;
	b=QODunuvWNn9Lnn5zCi9kC7YZjtlUxy7FNeCVSKgsXx9QOZnEvhLL6FS6puK771dqNP
	IOdZmimKD11nt2cchSwGCUsktjonnMKf6wjxTTD0JGIjnXBDpiGFD7BmW/BbWFX4VkRo
	nuaLLywZdbMU4Q4J7jIavs71H11BQ2nDK0/BFVL2UWI7jitouVHOLmd1gQDoVwv1Fi6n
	n6QcOK42v+E2GM4/8GoNm3uHxQ6rHbc1Ew2WYWC8yj+GU7DaKz9QwYpPCVUfc/CBhZI1
	FpFAONBm2XkFJw0ax715Cb477Mztc3fDz2MtHXkWkdhWf/XwfXumKBMiHHP0QQXaqR3B
	exmA==
X-Gm-Message-State: APjAAAUSwB+xkKjG/6sRbG5WZCQYN9+xTxYf7NTpt/PgSBq/fgd5Qai0
	0Am1lWxKTzDxpp1s24FTSw+3I8mBAi4=
X-Google-Smtp-Source: APXvYqx9r5PtdUF6lMGkM5IbqxXVJ5XKfS3Y5hcAJyOZdDY1sZAiXGv9dcElGcNvKkUlRYP+i4pTRg==
X-Received: by 2002:a05:600c:2944:: with SMTP id
	n4mr3825364wmd.22.1582040735146; 
	Tue, 18 Feb 2020 07:45:35 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	b21sm3858908wmd.37.2020.02.18.07.45.33
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 18 Feb 2020 07:45:33 -0800 (PST)
Message-ID: <64d9a5e38cb0159c1cce6f75b66f46b0d532c7fc.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Feb 2020 15:45:32 +0000
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Cc: openembedded-core <openembedded-core@openembedded.org>
Subject: bitbake memory usage debugging using tracemalloc
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
X-List-Received-Date: Tue, 18 Feb 2020 15:45:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I wanted to quickly share an example of how we can use tracemalloc to
debug memory usage in bitbake.

What I'd noticed was that for each loop through the parsing code in the
parsing thread, the RSS increased by a lot more than I'd expect. In
other words it appeared to be leaking.

I've given a code example below, you can see the RSS increase using
psutil or resource which basically show the same thing. guppy3 is able
to show there are a much larger number of sets and strings at the end
compared to the start but not *where* they're hiding.

Using tracemalloc, you can snapshot at the start, then at the finish
and then get a difference. You run bitbake as "PYTHONTRACEMALLOC=1
bitbake -p". Some example output is:

WARNING: /media/build1/poky/bitbake/lib/bb/data.py:364: size=45.0 MiB (+45.0 MiB), count=136542 (+136542), average=346 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:388: size=10.1 MiB (+10.1 MiB), count=320 (+320), average=32.3 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:419: size=3868 KiB (+3868 KiB), count=9634 (+9634), average=411 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:93: size=3643 KiB (+3639 KiB), count=61407 (+61340), average=61 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:357: size=2828 KiB (+2828 KiB), count=37541 (+37541), average=77 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py:163: size=936 KiB (-933 KiB), count=11639 (-736), average=82 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/BBHandler.py:83: size=0 B (-858 KiB), count=0 (-9278)
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:276: size=786 KiB (+786 KiB), count=3725 (+3725), average=216 B
WARNING: /media/build1/poky/bitbake/lib/bb/siggen.py:150: size=682 KiB (+682 KiB), count=4998 (+4998), average=140 B
WARNING: /usr/lib/python3.8/copy.py:76: size=730 KiB (+646 KiB), count=1962 (+1761), average=381 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:89: size=633 KiB (+612 KiB), count=3001 (+2901), average=216 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:88: size=633 KiB (+612 KiB), count=3001 (+2901), average=216 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:426: size=552 KiB (+552 KiB), count=4998 (+4998), average=113 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:84: size=422 KiB (+407 KiB), count=6002 (+5793), average=72 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:158: size=793 KiB (+372 KiB), count=956 (+680), average=850 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:296: size=334 KiB (+334 KiB), count=963 (+963), average=355 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:193: size=724 KiB (+309 KiB), count=554 (+158), average=1338 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:798: size=296 KiB (+296 KiB), count=435 (+435), average=697 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:145: size=322 KiB (-256 KiB), count=1964 (-1558), average=168 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:353: size=252 KiB (+252 KiB), count=3428 (+3428), average=75 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:23: size=1600 B (-242 KiB), count=25 (-4654), average=64 B
WARNING: <frozen importlib._bootstrap_external>:580: size=8878 KiB (+222 KiB), count=107185 (+2382), average=85 B
WARNING: /media/build1/poky/bitbake/lib/bb/utils.py:305: size=653 KiB (+185 KiB), count=7046 (+2206), average=95 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:90: size=188 KiB (+181 KiB), count=3002 (+2891), average=64 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:427: size=178 KiB (+178 KiB), count=164 (+164), average=1112 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/__init__.py:163: size=185 KiB (+156 KiB), count=12 (+10), average=15.4 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:331: size=149 KiB (+149 KiB), count=2235 (+2235), average=68 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:379: size=145 KiB (+145 KiB), count=9 (+9), average=16.1 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/siggen.py:159: size=144 KiB (+144 KiB), count=1 (+1), average=144 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:409: size=137 KiB (+127 KiB), count=1445 (+1358), average=97 B

(I'd changed the mutiple set() generations in data.py into one single
one at the end of the function just to confirm it was that which was
persisting in this chart, and to check I was understanding the trace).

The remaining thing was to realise those sets allocated in that data.py
function were being stored in the siggen code, which is apparent when
you trace the function call paths or know the code.

Compared to after my recent patch:

WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/ConfHandler.py:163: size=499 KiB (-1369 KiB), count=6297 (-6078), average=81 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/BBHandler.py:83: size=0 B (-858 KiB), count=0 (-9278)
WARNING: /media/build1/poky/bitbake/lib/bb/siggen.py:150: size=682 KiB (+682 KiB), count=4998 (+4998), average=140 B
WARNING: /media/build1/poky/bitbake/lib/bb/data.py:426: size=552 KiB (+552 KiB), count=4998 (+4998), average=113 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:89: size=381 KiB (+360 KiB), count=1807 (+1707), average=216 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:88: size=381 KiB (+360 KiB), count=1807 (+1707), average=216 B
WARNING: /usr/lib/python3.8/copy.py:76: size=433 KiB (+348 KiB), count=978 (+777), average=453 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:145: size=315 KiB (-263 KiB), count=1918 (-1602), average=168 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:23: size=1792 B (-242 KiB), count=28 (-4651), average=64 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:84: size=254 KiB (+239 KiB), count=3614 (+3405), average=72 B
WARNING: <frozen importlib._bootstrap_external>:580: size=8723 KiB (+222 KiB), count=105611 (+2379), average=85 B
WARNING: /media/build1/poky/bitbake/lib/bb/utils.py:305: size=653 KiB (+184 KiB), count=7042 (+2203), average=95 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:465: size=333 KiB (-168 KiB), count=3791 (-1747), average=90 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:193: size=252 KiB (-163 KiB), count=237 (-159), average=1089 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:158: size=274 KiB (-147 KiB), count=212 (-64), average=1324 B
WARNING: /media/build1/poky/bitbake/lib/bb/siggen.py:159: size=144 KiB (+144 KiB), count=1 (+1), average=144 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:90: size=113 KiB (+106 KiB), count=1808 (+1697), average=64 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/ast.py:287: size=456 B (-106 KiB), count=1 (-1947), average=456 B
WARNING: /media/build1/poky/bitbake/lib/bb/utils.py:395: size=203 KiB (+102 KiB), count=395 (+172), average=525 B
WARNING: /usr/lib/python3.8/tracemalloc.py:532: size=92.5 KiB (+92.4 KiB), count=1631 (+1630), average=58 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/__init__.py:163: size=106 KiB (+77.7 KiB), count=7 (+5), average=15.2 KiB
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:750: size=85.0 KiB (+76.8 KiB), count=518 (+468), average=168 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:409: size=72.2 KiB (+62.4 KiB), count=729 (+642), average=101 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:1064: size=656 B (-61.7 KiB), count=1 (-1129), average=656 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:587: size=153 KiB (-61.2 KiB), count=2508 (-1010), average=62 B
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:839: size=59.1 KiB (+54.7 KiB), count=9 (+5), average=6720 B
WARNING: /media/build1/poky/bitbake/lib/bb/codeparser.py:38: size=57.0 KiB (+54.3 KiB), count=517 (+493), average=113 B
WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/BBHandler.py:165: size=0 B (-48.7 KiB), count=0 (-137)
WARNING: /media/build1/poky/bitbake/lib/bb/parse/parse_py/BBHandler.py:171: size=0 B (-45.7 KiB), count=0 (-186)
WARNING: /media/build1/poky/bitbake/lib/bb/data_smart.py:489: size=45.5 KiB (+45.2 KiB), count=7 (+6), average=6650 B

so 45MB of data in just one object is removed, the overall gains were
higher.

I'm quite impressed with this module and I think we could use it to
find other issues in bitbake.

Cheers,

Richard


diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2d937a413cb..f4b25c336ed 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1890,6 +1890,11 @@ class ParsingFailure(Exception):
         self.recipe = recipe
         Exception.__init__(self, realexception, recipe)
 
+import psutil
+import resource
+import guppy
+import tracemalloc
+
 class Parser(multiprocessing.Process):
     def __init__(self, jobs, results, quit, init, profile):
         self.jobs = jobs
@@ -1922,6 +1927,11 @@ class Parser(multiprocessing.Process):
         if self.init:
             self.init()
 
+        psprocess = psutil.Process(os.getpid())
+        bb.warn("Init %d %s %s" % (os.getpid(), str(psprocess.memory_info().rss), str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)))
+
+        snapshot1 = tracemalloc.take_snapshot()
+
         pending = []
         while True:
             try:
@@ -1942,11 +1952,26 @@ class Parser(multiprocessing.Process):
                 result = self.parse(*job)
                 # Clear the siggen cache after parsing to control memory usage, its huge
                 bb.parse.siggen.postparsing_clean_cache()
+
+                psprocess = psutil.Process(os.getpid())
+                bb.warn("Mid %d %s %s" % (os.getpid(), str(psprocess.memory_info().rss), str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)))
+
             try:
                 self.results.put(result, timeout=0.25)
             except queue.Full:
                 pending.append(result)
 
+        snapshot2 = tracemalloc.take_snapshot()
+        top_stats = snapshot2.compare_to(snapshot1, 'lineno')
+        for stat in top_stats[:30]:
+            bb.warn(str(stat))
+
+        psprocess = psutil.Process(os.getpid())
+        bb.warn("Exit %d %s %s" % (os.getpid(), str(psprocess.memory_info().rss), str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)))
+
+        bb.warn(str(guppy.hpy().heap()))
+
+
     def parse(self, filename, appends):
         try:
             origfilter = bb.event.LogHandler.filter


