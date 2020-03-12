Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
	[209.85.166.169])
	by mail.openembedded.org (Postfix) with ESMTP id D967461B98
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 18:30:06 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id f5so6434353ilq.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=/FfjVskp9yRy+etMkxy3t+OGLbFIzgneTKnECxir4Is=;
	b=SunN0XQTeVKF4IW/BkASUHLV0YS7Mt5aFLNzhISbgkq0qvNRv3eUgpo0ip2k6enax8
	LdNEsk8kZgwNZvgLAR3TCLTENnV6vSEsahWew8O7Am2xSndg0oiQIdV1+w8Zhc08R8jP
	BAadUMyr4YksP4L83CkFSiUjSwBhyUjA0Pu8la+K/mnVfDvGPqfhXDQd1/zO4VAP8Rth
	z3FGa/BSDUjfYpVvZtf9RGmZfpSGm/dGlEr7oYURbLsFsG1/ToIQtMfBJ50ZmpPPeQT7
	LuF9HJ7/8gueqMGmqwauQ72Lp4U21uV+TyaKRb8z94tr7Id3QhVRriLrwdhz1rwsV04u
	89Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=/FfjVskp9yRy+etMkxy3t+OGLbFIzgneTKnECxir4Is=;
	b=DM95OFPOABxVhaP/Ejbe4qjsfJAUB4/Zt0fNxqcvZ9+iiaZKM4V30FmKRj9DA9l+Bf
	N5bEMwwdhIdB0JaZy3u8pBHxR8Xe0KWVE5Hvz5ugqiNxu1N333IHTaQCgfIv9GpBt4mK
	pPmD3WS4AETsVgkf7WRhAiWcOiwGsImm8XjYdCV7nQdoRmkjPU+cPIihQI80vNEjE6Tp
	fleFXcTY5mQwNTvm9hBo6jxKPs/mJEqdBQCv8wvwyxkmfDNt1h6MiIS58+OyJZEi6JKG
	TJaz99W0LzxlC9xzNfMjs9f3o8j988YnDanRkDSWhsPy5zP1HZ05CjdVysXlcNMaHVGN
	ycxg==
X-Gm-Message-State: ANhLgQ3qXYylqRxKEf6wOQF7vRuGIBslD/N8l51XMlwjq+QvCCd8RgzQ
	jpR+baKPMT0uCo4iPjamDRPNWJrivY4=
X-Google-Smtp-Source: ADFU+vuzpV5F+0EMh+XfuMmoe+dI4Px088itCDT2ilq77YJFRTekKZEmygL0sO4r52h40BpveKoyjA==
X-Received: by 2002:a92:c851:: with SMTP id b17mr3990430ilq.194.1584037807494; 
	Thu, 12 Mar 2020 11:30:07 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id b4sm6929029ilg.58.2020.03.12.11.30.06
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 12 Mar 2020 11:30:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2020 13:30:01 -0500
Message-Id: <20200312183004.8339-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH 0/3] More logging improvements
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
X-List-Received-Date: Thu, 12 Mar 2020 18:30:08 -0000

A few more logging improvements for bitbake.

Joshua Watt (3):
  bitbake: msg: Return config object
  bitbake: knotty: Treat verbconsole as a console output
  bitbake: Use logging.shutdown() instead of bb.msg.cleanupLogging()

 bitbake/lib/bb/msg.py       | 14 +++----------
 bitbake/lib/bb/ui/knotty.py | 42 +++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 34 deletions(-)

-- 
2.17.1


