Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web09.11855.1612644016370530661
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 12:40:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=AkFupcXr;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id a17so11718473ljq.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 12:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiR1Va55ELvRNdOO5FNck1/XZGOq99eXMUsLhQg25S4=;
        b=AkFupcXrlM/ks1FObLhbUoz/L5b6MrwMY89B8Wrk+FcdONn/Up4voN6zSuwnf2Tnfl
         a5IeXC43nm37Cz6X+9LyGeyHvudtwPq2wXIxVS/xs9wV4Me+Bh0CnfduCyDYDXQYDDE+
         NdyoJNDbktlkzRrT1hq+ULHFPQiPg+hmCDsJqUgN+2rTYsM58xCFkNyOqGp2hOE/ebNA
         /82Lq939PWohU4vmRwQyKfPM/9Ta969KIne/4SjcPmPqNYRc/bk6gBFHabmEVAH4aezG
         NqGUiDHTIkF0luFMqKu3exsnddPOIIoyA/ZrcFdGX28qyepnfIK2ICKuUJBfZXvF0Wi1
         a4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aiR1Va55ELvRNdOO5FNck1/XZGOq99eXMUsLhQg25S4=;
        b=GXsSelYzmCaaqX0RGwj6n/yEjhIKJNXOTKanlFwpwx5g2rLMPQyx7WNs0VFHO8vjxk
         S6/CbqInQJ6LMTcRsCcNLN6Vj+M9qHvzbv6Q8GOsPbifiIviL5NKqjsDEYIAXsIZf/9u
         I1rcNRNSV4GMTiAjVyGC1bbeSVBcyN49/9iThSNDywZq9BEiXbUg/N8y0Nva3gIcc1ii
         WR9ZgE29ZN82/Fy91S7Ffba0FFusi31/Dbl0HNxLW55tqM3W7kJgt+Pl85Ss9MNApwid
         Nl7TWziP8cUOpwm1jWmvCq659G+YHkZcFwWbYNqi7gDw12/5zNBekfhklaHxtuv2zKRp
         8nyA==
X-Gm-Message-State: AOAM533L3EByl0X1J0SrNjuMZKgHNuzy2je0SfHOnCDWZvL0Tm7uEcCH
	bUKD+DDw65ekIKdLump9cdzk4kYHfUk=
X-Google-Smtp-Source: ABdhPJxQLC/nVY3gNhiowyJnc6k3pDATSDMxVJBX/097x9rWYapTu6943KfL+3sj25SS4ZosEBaSSQ==
X-Received: by 2002:a2e:b165:: with SMTP id a5mr2008755ljm.81.1612644014236;
        Sat, 06 Feb 2021 12:40:14 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id l14sm1417109lja.46.2021.02.06.12.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:40:13 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] BBHandler: Don't classify shell functions that names start with "python*" as python function
Date: Sat,  6 Feb 2021 21:42:38 +0100
Message-Id: <20210206204238.293144-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If shell function name starts with 'python' or 'fakeroot' parser wrongly
assumes it's python/fakeroot function.

[YOCTO #14204]

Use regex lookahead assertions to check if 'python' expression is
followed by whitespace or '(' and if 'fakeroot' is followed by
whitespace.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
---
 lib/bb/parse/parse_py/BBHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 8a520e30..7fc16299 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -22,7 +22,7 @@ from .ConfHandler import include, init
 # For compatibility
 bb.deprecate_import(__name__, "bb.parse", ["vars_from_file"])
 
-__func_start_regexp__    = re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(?P<func>[\w\.\-\+\{\}\$]+)?\s*\(\s*\)\s*{$" )
+__func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$]+)?\s*\(\s*\)\s*{$" )
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
-- 
2.30.0

