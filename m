Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id E986C760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:43 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id w87so7235892pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3N+3bgDHBOANB15MWhrexb91CAz1vvH1aBtxsHP5lvY=;
	b=hXnnNJ9nh2a3bIal/aXSresCANjTPXHqviYRA7jtfH4HJ4qIvstRdwrINMTIVMQNiw
	U/ymyPVKpm8GsJdctK+Uh4qe8XcRtdW6wRd7KDomzta3g/N+yaK05J+Lw2tu972N3cIF
	mBcsge9/J3e95gksCPUSaBpxCw1H1vctpmT4DqthAu8dQTUGYoNHjXswpxO8rgYsCTgL
	p0FfTHuyobuXKA4cX2cI/UGbBimFGwGFqmSWOhsgcxvT4UBv+mcTN5/oARb95zEoZ1/g
	liSTuwq6vXIA5NVto0wtMtzpzSiagNBL9e7RmfloCfoNl6KHujXAbHT2VMujvXJiLMuO
	ZjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3N+3bgDHBOANB15MWhrexb91CAz1vvH1aBtxsHP5lvY=;
	b=m0240q9yzpmRRSjmHeVc/haNL5HM1pSGy//r5+yLwGGNZzuPvL4PI+CLhYv5K+9TTw
	c3XSRflC8lJnU9xo66iMToAX9q8d7MtWSUNdQn3MCCel5sUrIgioL75oSO9m3Rn+qIdb
	JzRn6nO8bRfKS4gxaf0u6Sg8oVmuznpqZx+DKQdGWAxlmXQbHH/v0ejyea5v7QHVWdw7
	QEbcddADjaF1PYdmSm9mQ3NDTzvcxa/QAQMs2FOMh8CZM6513wJYf18Wb4Gl2vrkySU3
	GYHmSphrLp/jzJrYYeLF9nybm1iGDemM6NgzvZmQl0dvuwqje6rqS1bzIa+GU3z+oGQj
	urcw==
X-Gm-Message-State: AE9vXwMBpsjbKVginlmkO6981SBIkOEKXsqKA4deodreCM3ST2wJjwSSWLUY6WIlr5o//kgX
X-Received: by 10.98.33.72 with SMTP id h69mr63420094pfh.28.1473085784096;
	Mon, 05 Sep 2016 07:29:44 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:43 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:23 +0100
Message-Id: <1473085772-17878-3-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 02/11] toaster: configuration Provide machine help text
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:44 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

When you change the machine from the project configuration page, you get
some useful suggestions as you start typing a machine name. However, the
suggestions only include machines provided by the layers added to your
project. This is not necessarily clear from the design (yes, it should
be improved), which means you might be looking for a machine, not see it
in the suggestions, and assume the machine is not supported by
OpenEmbedded.

Since we are in no position to change the design of this page right now,
add some explanatory help text to address the situation.

[YOCTO #8034]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index ff9eab7..30ee93a 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -57,10 +57,7 @@
       <p class="lead"><span id="project-machine-name"></span> <span class="glyphicon glyphicon-edit" id="change-machine-toggle"></span></p>
 
       <form id="select-machine-form" style="display:none;" class="form-inline">
-        <div class="alert alert-info">
-          <strong>Machine changes have a big impact on build outcome.</strong> You cannot really compare the builds for the new machine with the previous ones.
-        </div>
-
+        <span class="help-block">Machine suggestions come from the list of layers added to your project. If you don't see the machine you are looking for, <a href="{% url 'projectmachines' project.id %}">check the full list of machines</a></span>
         <div class="form-group">
           <input class="form-control" id="machine-change-input" autocomplete="off" value="" data-provide="typeahead" data-minlength="1" data-autocomplete="off" type="text">
         </div>
-- 
2.7.4


