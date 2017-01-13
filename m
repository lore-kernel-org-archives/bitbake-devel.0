Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id F33B071DA5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 14:51:26 +0000 (UTC)
Received: by mail-io0-f181.google.com with SMTP id v96so44977956ioi.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=ZtArO/oAfQ0gzqm6uw84S/HSZ70mEO2DXVWWScTmzrE=;
	b=bg7dpKgcWPLg+IhkDbjVGgj9XLx2EYfAnBlMes+PVuvG2XYjFvUjC+H+nSHyGPE9aM
	+GEBDqFhOjX5FcH4nFgupXtwgwrrUnkGjPwsWOfZyy9EhGXJtITQfj7pTZppLmW6M9uC
	bdULm0AzV3eOnJJTBLlV0ObEnlgudrEsSoohIU9CAYr967wPZ5Sp+7UkIqMSR47RyBzr
	BSqafkEjCHAWy497wWfA8ezaZpYMYH/RYfVAUxD2qG1nQWc9612VBalHwPSKXEq+5YfL
	QHc6TRp8HbF8qUzkCkm5RuKpF0P8IkogcwFtkWoHjA2NrvynexEzFgcMkHWB7D2MUOPy
	sLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ZtArO/oAfQ0gzqm6uw84S/HSZ70mEO2DXVWWScTmzrE=;
	b=ZaVDBCA+/22x0532PQwvjgT77uWsNP/JRHxtJwX9lX3upySuTs33cm4wSRQBrPxr2v
	OHS0jG28cOIBsONQuPsnvbKZqNG4vT1VCBus+m+2U3bWD/d/QosT4Mp08ic8+bwAQ6kp
	23SWXhxcmDDEh4H2oGKuBcXGqfZ5Z15IrSdjZn1F9eq7KT3/TFVsmq3hf720YjZrmU4h
	QDd7CkKHELnZGEEj1DGuycZjDJ14Uh6KXsU55oslJqWywnXRT+dfJ5B8J4b4QKm8dwjc
	hbSqfhQA+7C5/WgWYpWWz2aIrtcBho5EvvN2OBrwtokkj7NzZcy65Ox1wcLpHU4u9Z3G
	4W/A==
X-Gm-Message-State: AIkVDXK5bwfdxkmhMmtHplhgLXbVFwjwYbDoXpb0ZGTyTZlrND/zuJA73m9jrDgjiZj3ur9q
X-Received: by 10.107.143.86 with SMTP id r83mr17804737iod.121.1484319086772; 
	Fri, 13 Jan 2017 06:51:26 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A56056.dip0.t-ipconnect.de.
	[87.165.96.86]) by smtp.gmail.com with ESMTPSA id
	r203sm1006974itc.5.2017.01.13.06.51.24
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Jan 2017 06:51:25 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2017 15:51:18 +0100
Message-Id: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH v2 0/3] bitbake: rm_work enhancements
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
X-List-Received-Date: Fri, 13 Jan 2017 14:51:27 -0000

This is the bitbake side of the rm_work.bbclass enhancements. See the
OE-core "rm_work + pybootchart enhancements" mail thread for further
information.

Do not merge yet! The first commit is from RP's poky-contrib wip-rss
branch and needs to be merged from there. Once that is done, the rest
of the changes should be okay.

Related-to: YOCTO #10584

Changes since v1:
  - replaced prioritized anonymous functions with a dedicated event
  - replaced the implementation of the "completion" scheduler with
    the new code, without changing the name

Patrick Ohly (2):
  build.py: add preceedtask() API
  runqueue.py: revised completion scheduler

Richard Purdie (1):
  event/ast: Add RecipeTaskPreProcess event before task finalisation

 lib/bb/build.py     |  16 ++++++-
 lib/bb/event.py     |   7 +++-
 lib/bb/parse/ast.py |   1 +-
 lib/bb/runqueue.py  | 125 ++++++++++++++++++++++++++++++++++++---------
 4 files changed, 125 insertions(+), 24 deletions(-)

base-commit: 4170cf874850b950f31d2e36c895c110c0b096c3
-- 
git-series 0.9.1

