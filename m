Return-Path: <gavinli@thegavinli.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 9837E7F8CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 00:59:11 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id r18so10609619pgu.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Nov 2019 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=thegavinli.com; s=google;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=oYGrMiFjr/AV9KRDxHfXNRfoKPSb486JHCmQbtdT9Rc=;
	b=Q5T38TRVNuHXaq0GGUUMnV0lMEg2KIxzkU2QgfBN7XE46K6QdzofnD4HsrhfoPQ7/G
	3Ht+ETvZPSwBtRSIHs77b+d52kQLMryQHX2QHYwcDRWBLr7oFHX4e2jMKWggOQ45ebcF
	E/YyIRnfsskr9p8tmoyniVZsGA3fynbxawNCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=oYGrMiFjr/AV9KRDxHfXNRfoKPSb486JHCmQbtdT9Rc=;
	b=dpw5gCkgtSvS2teGpbfUSVvlYoBo8P9oGrE/ujVFY4F5TCUYdXs8JZ57/jLL3gTELl
	fwsbsM4e0l87nSXiqxxgBPp0TGyBuWwsLGSiMD/N64Ot8PdIc6nkSXjgfbSx3eTE8KzC
	OZT0hZ8tw5EWQJ2FPz61rSYoSiVfpON8DtAZrspBjrulCZ8AvTSQBNpmi1dsiGKX8Xl6
	qCA38saxtl8TfXF2Pv3qa8xu3vOqwAJ8nAY9XJjRDc5DZJox20bGt/Y0BFWjTHTOewFz
	tVHrQ/2cQ+3qeIvpAFVht4yYz7bybIvRqym3i6MSBJwsKNmF9cN/YSVUoZdC0je4eCAl
	muYw==
X-Gm-Message-State: APjAAAVGK8w2RYKrdrr/pJ9usIEGgfXeY4KIJFP2xOm/XKW/N1+iaeU3
	pjRe0QdY5Km9kDvDI2eZTWB65EIJ8bQ=
X-Google-Smtp-Source: APXvYqyLnIgsh4RkACmQoNAUqz9I/A5cnVByTXoZqkbuuvXJWEzechls+9KvH9NprtUCQ4oecShYAg==
X-Received: by 2002:a62:b405:: with SMTP id h5mr33393261pfn.234.1573520352308; 
	Mon, 11 Nov 2019 16:59:12 -0800 (PST)
Received: from mtgav.corp.matician.com ([2601:647:5a01:84c0::a53])
	by smtp.gmail.com with ESMTPSA id
	v3sm15124844pfn.129.2019.11.11.16.59.10
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 11 Nov 2019 16:59:11 -0800 (PST)
Sender: Gavin Li <gav@thegavinli.com>
From: gavinli@thegavinli.com
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Nov 2019 16:59:04 -0800
Message-Id: <20191112005904.1809991-1-gavinli@thegavinli.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Cc: Gavin Li <gavin@matician.com>
Subject: [PATCH v2] bitbake: prserv: fix ResourceWarning due to unclosed socket
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
X-List-Received-Date: Tue, 12 Nov 2019 00:59:11 -0000
Content-Transfer-Encoding: 8bit

From: Gavin Li <gavin@matician.com>

With PRSERV_HOST = "localhost:0", this message would occasionally pop up
during the initial cache read:

WARNING: /home/gavin/yocto/poky/bitbake/lib/bb/cache.py:446: ResourceWarning: unclosed <socket.socket fd=10, family=AddressFamily.AF_INET, type=SocketKind.SOCK_STREAM, proto=0, laddr=('127.0.0.1', 45655)>
  value = pickled.load()

The file location stated is irrelevant; it just happens to be wherever
CPython decides to run the garbage collector. The issue is that after we
fork off a PRServer, self.socket is also duplicated. The parent side of
it also needs to be closed.

Signed-off-by: Gavin Li <gavin@matician.com>
---
 bitbake/lib/prserv/serv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index be3acec36a..1d9148b817 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -243,6 +243,7 @@ class PRServer(SimpleXMLRPCServer):
         try:
             pid = os.fork()
             if pid > 0:
+                self.socket.close() # avoid ResourceWarning in parent
                 return pid
         except OSError as e:
             raise Exception("%s [%d]" % (e.strerror, e.errno))
-- 
2.23.0


