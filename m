Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id DA450758DE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:40:05 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so49801981wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=9GN+ZYHCD1DyEGSQkR85I9f76nLRIUKO2JcARjBlUec=;
	b=mPBcfNL+GrtM5xB1TxKFbq/OArbwybJH4VOvc9VhP9KZUmFyN7bkBVxfSlI1mQY1im
	w9PJTJfOFu5yrsiDk+Q9TgzQrj91szgKHrfwdUuXuiHfhJtVz5e/MPVWE++R3rFzYbmY
	pzBBogNSFYG/Yj8YItffQZRlQUHkp5H/PYNRym4ZkbLrY+o6hLMl2phFdSNejdiRiEqj
	09k6bbLcSSOeh+kz+XTIQ9PMzfmhe9UktcGnNFlW1MJB0CydgxBvWiNiHsyC9qdho0DC
	KhfwMB95aNG9ke1SmrWFG4U/+EBUbAG8Yae0bERyf1AkM9GQBWZTJI9BhA7OvBDc8EOB
	oOug==
X-Gm-Message-State: ALoCoQk+ioJHfCnqNau4PvHzKFV+rwn3OSRFB1hLYiC4zCer8kbyV0zM/QSBPgtlbMDynrrml6Ai
X-Received: by 10.180.101.138 with SMTP id fg10mr9158763wib.46.1433947206168; 
	Wed, 10 Jun 2015 07:40:06 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u6sm14845793wjy.13.2015.06.10.07.40.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:40:05 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 253D656124D; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:04 +0100
Message-Id: <058e9db05767f2d46d46c02dd5043bb0f6b8e460.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Cc: Vlad Fulgeanu <andrei-vlad.fulgeanu@intel.com>
Subject: [PATCH 16/19] toaster: tables: Remove obsolete field_name for select column
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
X-List-Received-Date: Wed, 10 Jun 2015 14:40:06 -0000

From: Vlad Fulgeanu <andrei-vlad.fulgeanu@intel.com>

field_name is no longer used for this kind of column. So no need to specify
it here.

Signed-off-by: Vlad Fulgeanu <andrei-vlad.fulgeanu@intel.com>
---
 lib/toaster/toastergui/tables.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index b85527e..43b81a3 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -227,8 +227,7 @@ class MachinesTable(ToasterTable):
                         help_text="Sets the selected machine as the project machine. You can only have one machine per project",
                         hideable=False,
                         static_data_name="add-del-layers",
-                        static_data_template='{% include "machine_btn.html" %}',
-                        field_name="layer_version__id")
+                        static_data_template='{% include "machine_btn.html" %}')
 
 
 class LayerMachinesTable(MachinesTable):
-- 
1.9.1


