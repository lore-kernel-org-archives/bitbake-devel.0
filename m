Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id A92216C5BE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 22:14:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id t3so24312403wrr.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Nov 2018 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=dC91yHSQdF8Z/AunG6+gHa0N9jdDvfsg5W4P+JypIZU=;
	b=hkVz9TK8SYuswgMWpby39WG5YwbIcK2r5N8vYnzXNS1lrPXJI0TomyP+XLIR8jmx30
	eXt7xM1M7doxoVV1Uq0qdsji7LwFaeMiv5ogXJFfa6vospuKzVqp9zzwzqucdGwcMXEC
	Nkw95eDj9AgTTQVlcxS9eYKw5BcFo7dlqFRTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=dC91yHSQdF8Z/AunG6+gHa0N9jdDvfsg5W4P+JypIZU=;
	b=Lp1i/r6iw5UVHwQbsmg4ctwo/DYntdhWyRkGbsnx25bUQg4jdDBuNBwVESsvqkGTq0
	Ahxe/YR+LzcrkD9O2ijQYKBuywVzk+hXn1QFGAIJU6VRHTDAlA2UeWYRH/doz1l6SMgZ
	FQnChg+dGn2sanqZp9e2aKX/N6tRnH0bo+ItSXtdSFpQ/4QnJ4VSF/jXInrtN26anI5x
	3SGecLNZ0HxDEe2r9rp+RIYqwrHIWrweQjtbtVuwcXhxTvxp2rIbiPV44tepoHGU6EJT
	jwbmRYjTlfyVkmxJxpu/0/5XIdoCLMXoxEdRB2ti4aW9y1JUygjfgy8ABbhMvR9G/xbg
	NLMQ==
X-Gm-Message-State: AA+aEWY8hgANwCLRxsQLBa13jKYLb1UrIVtaNOdaee4JJeMBEQkX7Rni
	O+6d3ns3HHwBMIr5JpCJNlXUQRP+6+o=
X-Google-Smtp-Source: AFSGD/UbtIVlNROh4JJeqtS6Y8GLZHQY5uuB9Z4/cbJKc6NWF2POHjaYejqpGtxwn5XbBy1W+GdJMg==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr29129604wrq.225.1543356887661; 
	Tue, 27 Nov 2018 14:14:47 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p6sm4160084wrx.50.2018.11.27.14.14.46
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 14:14:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Nov 2018 22:14:44 +0000
Message-Id: <20181127221446.30899-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 1/3] server/process: Show last 60 lines of the log if the server didn't start
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
X-List-Received-Date: Tue, 27 Nov 2018 22:14:48 -0000

We're seeing issues where the server doesn't start with no logs as to why. Allow
the server to print the last 60 log lines just in case this shows us something useful
about what is failing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4e0d9c2dbc..38a62fa34e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -412,22 +412,28 @@ class BitBakeServer(object):
                 logstart_re = re.compile(self.start_log_format % ('([0-9]+)', '([0-9-]+ [0-9:.]+)'))
                 started = False
                 lines = []
+                lastlines = []
                 with open(logfile, "r") as f:
                     for line in f:
                         if started:
                             lines.append(line)
                         else:
+                            lastlines.append(line)
                             res = logstart_re.match(line.rstrip())
                             if res:
                                 ldatetime = datetime.datetime.strptime(res.group(2), self.start_log_datetime_format)
                                 if ldatetime >= startdatetime:
                                     started = True
                                     lines.append(line)
+                        if len(lastlines) > 60:
+                            lastlines = lastlines[-60:]
                 if lines:
                     if len(lines) > 10:
                         bb.error("Last 10 lines of server log for this session (%s):\n%s" % (logfile, "".join(lines[-10:])))
                     else:
                         bb.error("Server log for this session (%s):\n%s" % (logfile, "".join(lines)))
+                elif lastlines:
+                        bb.error("Server didn't start, last 60 loglines (%s):\n%s" % (logfile, "".join(lastlines)))
             else:
                 bb.error("%s doesn't exist" % logfile)
 
-- 
2.17.1


