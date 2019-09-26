Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
	[209.85.166.48])
	by mail.openembedded.org (Postfix) with ESMTP id 519D67E21C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 17:54:05 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id n197so8800885iod.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 10:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=559xKnw3GGbV6/mzFopdXx4TDU6axbRCnKRIYeOXbhE=;
	b=jq5lGq+h4sy0BWIyfUXD56crP/MWDNmt/FuD4r5myxGp7jCVnjFTEmQbACg4LvnGAv
	d7ehYbW93a3jQkr7Xxrwsfg9kSkoYxe/pjL6f21Y7eSMrvBvfhJQq0U+qWK3F73rjH+s
	jwJn642zDZbmUcOC3TO5nUHzjm2LvLbt4S9074M9DzIB/38txot+UM9ptkNRbBgh1TJX
	HdllhlpwEwhw/CVXwOo9+41lYrtnapMU/5IeChGiwT3mnponwhnsIF7Foo8TIN9wTLdy
	KK9b6F3QLQ+IykRC3CGTZDKZCeCkHXTqT1ZYz8/2Qp+ieFHgVCdmZOJ5vIoAer4uegqF
	Dlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=559xKnw3GGbV6/mzFopdXx4TDU6axbRCnKRIYeOXbhE=;
	b=g+suvNp4sx2NgDwFJI7IbeWI0+yYCc8rgpyxOdVM0vlmcs9MbzN1XxBxwQP5qq0RGP
	jW0KPNzp7DKHrTTWbO2uz3OUbi8W/Uo9zoch5n4fubtrDnMimpSQfxBSQlI623t5bOog
	5jeKcpNhgIy12xAIBhNSxnF8jdiF5LDb0u5WoElzw4vr9OBEh/RdUxEBjj2KcEEpAzPp
	3wFnm4/LjJ5eauKnz2EU41V67y267rTh7XD4oFHfVKuePsE6VYDSAG5vtlydWNOVvFYS
	uh10fzYXqAkycoKuzW5zZtSUNPrQH4jie3QmpqUOLtsawi0kAndnztLOybYtwp0Br7vh
	9aDw==
X-Gm-Message-State: APjAAAWNjk34IgyWeqE40TvQyxlPGgc45g6GpZV44Z77cf9ir/UqM1aI
	XRpvRwCPyFSLCiTYPEroFvxxf7U7
X-Google-Smtp-Source: APXvYqzPppkO/AX9rlXyMGM2cVdbchIXNpVYMx2GlDIwpleI/InGdLxODLFZG21dHR2+TJVKYpNNXw==
X-Received: by 2002:a92:1a4f:: with SMTP id z15mr3901467ill.199.1569520446085; 
	Thu, 26 Sep 2019 10:54:06 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id w22sm1209874iol.8.2019.09.26.10.54.05
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 10:54:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2019 12:53:57 -0500
Message-Id: <20190926175357.11975-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] siggen: Fix attribute error when hashserver fails
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
X-List-Received-Date: Thu, 26 Sep 2019 17:54:05 -0000
Content-Transfer-Encoding: 8bit

The HashConnectionError class was moved to the client module and needs
to be updated.

[YOCTO #13537]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index bb660d29b02..a4bb1ff7fbe 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -442,7 +442,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
                 bb.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
-        except hashserv.HashConnectionError as e:
+        except hashserv.client.HashConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
         self.unitaskhashes[key] = unihash
@@ -510,7 +510,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                 else:
                     bb.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
-            except hashserv.HashConnectionError as e:
+            except hashserv.client.HashConnectionError as e:
                 bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         finally:
             if sigfile:
-- 
2.21.0


