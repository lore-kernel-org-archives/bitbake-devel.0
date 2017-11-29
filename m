Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pg0-f48.google.com (mail-pg0-f48.google.com [74.125.83.48])
	by mail.openembedded.org (Postfix) with ESMTP id 358B071A8C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Nov 2017 22:34:58 +0000 (UTC)
Received: by mail-pg0-f48.google.com with SMTP id k134so2141122pga.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Nov 2017 14:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google; h=from:to:subject:date:message-id;
	bh=51e8YXzNRxckHY2UDRI7h26Dsliw+dLrXCwpUpIdZxU=;
	b=Cf21yyY8hN4XvKiaJvI/V4YN9OkJ66YvYPTJQfvDwt77rm3ISVLI1pLFRujQ+xR/qq
	FFUrY3PkTdynN3ClDE8yDiO8DtqdMra3kcoJIGDMyj80jGjoCgj7WqZ/Azg9+gZPNkDX
	C+sN+NXPGcX7E+IhApS3+zxDHp7q6dnvjz/hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=51e8YXzNRxckHY2UDRI7h26Dsliw+dLrXCwpUpIdZxU=;
	b=Gz6u63bl6F60h5R22f5Es03cNvxFSM3vQo2AjyE1FECaIDTa/GZQaxvDZchdEqPAjV
	N8GAplm1660W/DOH+Fv3bMrjRUPNchRZKFZqobDjJ2m8rUty1PhsrZ1SeoFieIoLSN7l
	FilWIjAVrGQrOJ8JcymoAnsnUhJlNPbB8S/KfnUdjw2E4PXl2fdwwlj/1wwL++uHxIao
	5csoNE8L9Q1kgxgkD0ejHx5ibrvq6E09A4tCQsMEGGB2afsOSjI9QSa4nEVvu2uAy2if
	r/pvahjFtYIJLPOcpH26PaQDnaDpJ9yom3z7LWIm+L6jA4jStbsxtJWo2Y40tsb53bb8
	BeZg==
X-Gm-Message-State: AJaThX4dPPksMhCljtIiEYd2lJWwCVpq3QG+ANbmagqUuXuH5LslCcBr
	/wCW45C0XAlJVrrLg3HHKODYOOUg
X-Google-Smtp-Source: AGs4zMb6teRTQIeKUUJg3alui4xj0eMK6RBy8e6Xc8Mx2rio7B9fLMgG/fF5tGH+ohsv/l0wm/DyoQ==
X-Received: by 10.101.72.132 with SMTP id n4mr397432pgs.288.1511994899200;
	Wed, 29 Nov 2017 14:34:59 -0800 (PST)
Received: from c4.lgirdk.com ([4.16.80.118]) by smtp.gmail.com with ESMTPSA id
	u6sm5107888pfk.126.2017.11.29.14.34.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 29 Nov 2017 14:34:58 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Nov 2017 14:34:56 -0800
Message-Id: <20171129223456.13875-1-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.14.1
Subject: [1.32][PATCH] bitbake-layers: fix layerindex-fetch for Python 3
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
X-List-Received-Date: Wed, 29 Nov 2017 22:34:58 -0000

From: Paul Eggleton <paul.eggleton@linux.intel.com>

The data we read from an HTTPConnection comes in the form of bytes, but
we need it as a string, so in Python 3 we need to decode it (missed in
the Python 3 migration).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bblayers/layerindex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 10ad718e..f53a47fc 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -56,7 +56,7 @@ class LayerIndexPlugin(ActionPlugin):
         r = conn.getresponse()
         if r.status != 200:
             raise Exception("Failed to read " + path + ": %d %s" % (r.status, r.reason))
-        return json.loads(r.read())
+        return json.loads(r.read().decode())
 
     def get_layer_deps(self, layername, layeritems, layerbranches, layerdependencies, branchnum, selfname=False):
         def layeritems_info_id(items_name, layeritems):
-- 
2.14.1


