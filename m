Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C35C624D4
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 22:56:13 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.191.1788303363884645095
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 15:56:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VHwyVqt+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so265040f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788303362; x=1788908162; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9+fSbuzVebk54t/sgt75seavJgrJDUkMhSgsetVVhfA=;
        b=VHwyVqt+ORI3meQGZ9yT3xz+3yUBf45sye/a5AsdVXQO/J0MffErMfveTD8qmikqpK
         v8NNZ0+M6gVCpA7+/BKE42LjtK2gTnaciu/6aaWm9iMYCnKuCqeX2HnF/bNz4WhHlHtJ
         643xXkpSNroVp9JszpM+9bZTYYevwZzfA0f6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303362; x=1788908162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9+fSbuzVebk54t/sgt75seavJgrJDUkMhSgsetVVhfA=;
        b=pKdFUFJdkn+IwQqYGlkqBFXRcIgfflyztrKTuQwdTiuYj565oFR1RhX0bG8xuQX3Mv
         bX9cRMI00FBEZQboI44xeZBkDd7HRMRtUTf1sOLDC7947LWZv1Hvo8h7aZYt2lcm4Hep
         YhIaeU+WF85OCzLtMea9Xd78Gyg0w9JtqIhZwJMM2AZ3+N42jmSxB+wu8pr/KdsdR2n8
         V2aWtqZ7qheMCfW+SQKH3/v2vOLaLrAu1HW2ZguREixk9wOzy5FYyxDeSg/HPoT/tKuJ
         jWtzZVL6r/BEc+lOeFGdcsHme3k2ZNGiR6okDXaBRtcMN7q+mvishTItcI5mVs6pQGl2
         7uaA==
X-Gm-Message-State: AFuF++ltUduLY/3QLpIwrmWJQEZY36FXx9NA24VNQyGzIqJ+8TR/yC1r
	iLJyC4mq1WsaYm8FxxYmGHNj4x3tsvrJip3TNoFQUq21URbW2044wiFA265MtNgHy2MDTB8dBSY
	URk2O9L8=
X-Gm-Gg: AYBFou01ZXajvalKbimJg7Ssa3LQpAWN5n3H4zA2dUzsqKNmls+jZdGXznsKa75rSmb
	YlH94uHy8wU8KnKnQyii9v7QOyoirO0s9k11l0KEQbnQDlEXHOUTMimq1WvUvG2K05U71g1Zp4W
	o5hDG0oVB7pyUutmnZ72/WomR0OF4//8xCrbmOsS5+8zc/U04nMdQG/smpQrIdYcQ3NvcDpLGR5
	TlKW6sbcZEQTeOTl/PUZBZZ4hDPOEAwIoUAXrk0lyEJfXpYfA3Wv4iL6wqP1nVo2UOzpOIZiXku
	2tY76udKFvgR4smdvp58hutlF1p5UKT0YUri4OUNOqmuIpNqkPgqE3yi+hUu6Lj2rwAli0m0wA3
	jYxjdlPNubaYT4Ju+AeAyCmjt1QTx2NW/WtDighjgXcAEH9nku91RaepFkfPbf9wB9+o1zSDATZ
	RQtt2S8auSSTVgvRyWWiV/9YwTmUUfqHBbDzZm6iD+Ie8Ega6hKzfwDcO1KXowCw8oDRDqUJV4h
	ASxhiPC2aYNnCPcnCri0a/XfQ7m
X-Received: by 2002:a05:6000:2c0a:b0:482:d94e:f33b with SMTP id ffacd0b85a97d-4847b620f94mr1128640f8f.0.1788303361143;
        Tue, 01 Sep 2026 15:56:01 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm1644388f8f.21.2026.09.01.15.55.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:55:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/5] toaster/layerdetails: Add id labels to for to make tests more robust
Date: Tue,  1 Sep 2026 23:55:53 +0100
Message-ID: <20260901225555.2254932-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
References: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 22:56:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20142

The two textareas are hard to tell apart in the test code, add
id labels to them so the tests can work more effectively/robustly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastergui/templates/layerdetails.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/layerdetails.html b/lib/toaster/toastergui/templates/layerdetails.html
index 923ca3bfe4d..2f23156a12a 100644
--- a/lib/toaster/toastergui/templates/layerdetails.html
+++ b/lib/toaster/toastergui/templates/layerdetails.html
@@ -328,12 +328,12 @@
             <span class="current-value">{{layerversion.layer.summary|default_if_none:''}}</span>
             <form style="display:none; margin-bottom:20px; margin-top:5px;">
               <div class="form-group">
-                <textarea class="form-control" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
+                <textarea id="layer-summary" class="form-control" rows="2">{% if layerversion.layer.summary %}{{layerversion.layer.summary}}{% endif %}</textarea>
               </div>
               <button class="btn btn-default change-btn" data-layer-prop="summary" type="button">Save</button>
               <a href="#" class="btn btn-link cancel">Cancel</a>
             </form>
-            <span class="glyphicon glyphicon-edit"></span>
+            <span id="edit-layer-summary" class="glyphicon glyphicon-edit"></span>
             <span class="glyphicon glyphicon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
             </dd>
             <dt>
@@ -344,12 +344,12 @@
             <span class="current-value">{{layerversion.layer.description|default_if_none:''}}</span>
             <form style="display:none; margin-bottom:20px; margin-top:5px;">
               <div class="form-group">
-                <textarea class="form-control" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
+                <textarea id="layer-description" class="form-control" rows="6">{% if layerversion.layer.description %}{{layerversion.layer.description}}{% endif %}</textarea>
               </div>
               <button class="btn btn-default change-btn" data-layer-prop="description" type="button" >Save</button>
               <a href="#" class="btn btn-link cancel">Cancel</a>
             </form>
-            <span class="glyphicon glyphicon-edit"></span>
+            <span id="edit-layer-description" class="glyphicon glyphicon-edit"></span>
             <span class="glyphicon glyphicon-trash delete-current-value" data-toggle="tooltip" title="Delete"></span>
             </dd>
             {% if layerversion.layer_source == layer_source.TYPE_LAYERINDEX  %}

