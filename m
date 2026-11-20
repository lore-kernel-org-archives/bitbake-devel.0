Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6372.1795182809295546351
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2026 05:53:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=AE8fn37r;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-49465892f7bso732769f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 05:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182807; x=1795787607; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3CbXOum2UDjBzAH/fJwr3HXZzgIW0YgYS5ZqDVktPEU=;
        b=AE8fn37rTEJjX9UpRJEg5FY9jFJ7itkrVfbfvCTA2szYxU/PbSiJebOfcywxqkGaax
         Ta/UtZhPjvAtmMAzPJN3E3hteEGAo2uaJGuWdjs1G4eI7fNRnLh+nqdrR19Rt7yR7llW
         8X0iT81gV8Ye9ckxLcEgxQFusRiwlkP9QDVVoRtJXG1xVcFlf3GomQoHg8Uadjiu6ShA
         5cjy2W4QFIvbMaFSKx2b9plewhjs+0OTlfvkkrwSFX7oYpwNuABHjFtSw+aqsq8h2R7T
         5mdTVCYdYxzaDTf3MWPv3oCByiBcdaif4lD2ywmJdkJtwz3q1miLilqu6K3nt4Da17Lx
         jggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182807; x=1795787607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3CbXOum2UDjBzAH/fJwr3HXZzgIW0YgYS5ZqDVktPEU=;
        b=fCo/ugwHqIPg7/3g4s18VrjbgD6xfObgsYY/8/6jcVT6oF+Z0cmg9YhjdaW1PNBsvW
         jl14xKXkgGQyrsapWNqDfUL0zgsI9fklLgcbLyDtYfM1s2ZjgtcSMNIhfSYL59R6zbn9
         JW80GDeTFqVoSMJSrtc3tW05D9EMtgsGQIZInAE3RZKCGU06hsuy//SV4t+wH7QDpTzq
         hVmoE8BRyEiU0duFzFopitCPKl7NLj4Ppg86ZeXhsKBc1rXuWMfuaFaaLtIjDtu4wF34
         4Y6/tVxBjOG4bCzaOmfwlN8AQGjJxtAjLx+sbZ3VGIpnDylNj64lzN/vGonBbIn23ieA
         g9Pw==
X-Gm-Message-State: APuU4Z+ounurbr8dPnn2lWRWZyZEyyB2sKC2i/pPVy/BztPoZF76N7ge
	HCYTktJxomqf/euSfiohK/+r3G7KaX+vGUeC1BLlXtefJa2CML525siIXOjB76D8
X-Gm-Gg: AZFdTZe7VLS85CV+SoFmXlV64Rs2Bn/o0SDD5uz9RhtshZpdUOOlGeem8C4T6JUmVt1
	L6WXAfzWNdfcgEDHWl8BSvPVzMdZaJoaBml3ZSmEsHTSf1UFTJKREdPQ1wvcdrxYwa4/ZrYULoZ
	sJ8MDTQHVbOct0soJ+uzqGFKePH2RH3xBz1ddFHOhoVBSWWnPKP6fpOIZ3LzY0Xhl3tFTvbtXui
	FBQOo/uJbtRIyCLVAdJntcnS9VYLo2VZ7rUn+mCnU+GqfDQKG3ncBzGAX3UtSsSGXO2BGWrO5Qt
	lHdK6P5B1EcO4ZjbqJ9nsNYDS/PwiR/ZnMD4TnNr9a92B2vQaIgKI910E4/GU0RLABsprfP7Ig5
	o2AgjeUXwAVQRshGJ5fRoY6JA3pYzcbhJREmJwWr4Lk2uqvjgeAE8oK/1U1Il+eJxhB5E2cJ9QT
	UoEYBKPHMksHFaN8mUN87AvOdtYxQwPNwP0mmi9qpSfoWEkPGVv49+rd6WDYOG7047+QH/Ythph
	vfGD8jQvMeqr5nOPVC/G9ZnMOgA2TE+ZOJnqXMjWWYiiU4gbeBeqwPwBqXLzfZmmL7eiTBRE+1X
	UKrAItGNvb8lnFQ5VQOsy+h98YVgJMOU
X-Received: by 2002:a05:6000:490b:b0:491:8462:20be with SMTP id ffacd0b85a97d-4abb1baaad9mr6277288f8f.12.1795182807455;
        Fri, 20 Nov 2026 05:53:27 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm6018485f8f.36.2026.11.20.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:53:26 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH 1/2] cooker: Write variables that are not JSON types to the event log
Date: Fri, 20 Nov 2026 14:53:22 +0100
Message-ID: <20261120135323.2627478-2-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120135323.2627478-1-stondo@gmail.com>
References: <20261120135323.2627478-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 13:53:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20466
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

EventWriter.write_variables() writes the history of all variables to
the event log as JSON. A variable can hold a Python object. For
example, sstate.bbclass stores compiled regular expressions in
_SSTATE_EXCLUDEDEPS_SYSROOT during a build. When the same server runs
a second build, json.dumps() fails:

  TypeError: Object of type Pattern is not JSON serializable

This occurs with tinfoil, for example in "recipetool create", which
starts more than one build in one server.

Write such values as strings.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index a6bc2827d..abc516649 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -124,7 +124,7 @@ class EventWriter:
 
     def write_variables(self):
         with self._open() as f:
-            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
+            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}, default=str))
 
     def send(self, event):
         with self._open() as f:
-- 
2.56.1

