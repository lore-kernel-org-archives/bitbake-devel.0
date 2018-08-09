Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
	[209.85.223.178])
	by mail.openembedded.org (Postfix) with ESMTP id C6D8178E85;
	Thu,  9 Aug 2018 22:10:45 +0000 (UTC)
Received: by mail-io0-f178.google.com with SMTP id l7-v6so2237965iok.6;
	Thu, 09 Aug 2018 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=srjqZANC0+L6n72IbRRzBj4ZaheoNmEhYm5N9OxiNuo=;
	b=MZqlEDh7gHxpJhXK6f1WTudt0OGMOe1qJK7TOFfUEYwzk1cnyKiavhCaGAUpc48Rq2
	hsk9plninrnmJKxUl6yYLud/L/ObW0cV2sEjPejqhB6DO6Xg/falrVuQePZcGKCADgOD
	iUhi8nZhw2aApIV0VpGWiMnuUUZRKj2ZL7fKJ6zxSF7v2z7Y/Q9kLgyanENN5p9GWXI9
	60Ah0Pd0dDIloVCgWwZUadbhJakp7cdmZMwCNtjlakhLUQNdXZcqKIrYW+lW7hIaWH01
	Y/itSO/gRJvaeK5bfWsxOIHwqnbaHayLlhCo80hq75iag5mR+c/yAv8vFA+zEzOlIb3M
	hIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=srjqZANC0+L6n72IbRRzBj4ZaheoNmEhYm5N9OxiNuo=;
	b=e9PJojOd35MEBf4QqWaycNYTQK8X403kJmaSL19jVXicay7ngwMj2HJKEDs/7jmPtw
	auwJXd10gHsJNEYscmDPu2bYxq4Jdtd3p6nz3o4ptHrmfid4uQ32QVdlTxo8vVWvWSGx
	CQp+eGBC+LbVCZiVEBjNIvU1MaBXZmDG/Tdjz5t5OAQyM2i0NvLHIIbqdXOl218IrLuz
	75C35eQLgDq+jArmLafXbfc9+URuyRUEdDushVzqfEPZ8pBQ6CGkaysdopu9nDCdg12V
	ZEb9TxwEzup5GRZPhLDLPcaXK9AGa0p+UNWeOc1G7XdgGC07o83idwfXVbjDD8opqlYt
	LZtg==
X-Gm-Message-State: AOUpUlGRPOVtdsb65e25efwrzDfiMlDFmRws3RSswRt1diodTu/NK4wy
	6oouXQHeNHL/j9eGaebb4d5w7sCT
X-Google-Smtp-Source: AA+uWPzIiWWhCgabFpRUH/JT+ZWVueciaIZ0LrnuFp+v0ALbuWZgTodViUHLBxeiBm7iFkrxsooj5g==
X-Received: by 2002:a6b:5b16:: with SMTP id
	v22-v6mr3185971ioh.265.1533852646646; 
	Thu, 09 Aug 2018 15:10:46 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:27 -0500
Message-Id: <20180809220840.26697-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 03/16] bitbake: persist_data: Add key constraints
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:46 -0000

Constructs the "key" column in the persistent database as a non-NULL
primary key. This significantly speeds up lookup operations in large
databases.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/persist_data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 1a6319f9498..2bc3e766a93 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -94,7 +94,7 @@ class SQLTable(collections.MutableMapping):
         self.table = table
         self.connection = connect(self.cachefile)
 
-        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT, value TEXT);" % table)
+        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT PRIMARY KEY NOT NULL, value TEXT);" % table)
 
     @_Decorators.retry
     @_Decorators.transaction
-- 
2.17.1


