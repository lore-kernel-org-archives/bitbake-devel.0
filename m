Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.9121.1621347311188430104
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 07:15:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=Tja1F7DW;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.177, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f177.google.com with SMTP id v13so5145852ple.9
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 May 2021 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7wq75tjrYjFirFQ74uk4J5adNLKuR7GIvypCoUjFLM=;
        b=Tja1F7DWkrnOXR/+jH0xJS7efyrpPVz8dTaMkbc+8OxHTkLANuW8Vss/cUv8CBcoHm
         6GYqMjO7mNcsSkDkuj5eXl42McQMICB7Q6sit4PuhT3ueRxm954CJmBozewf3lzgUMRz
         KHaXzB7KmmoJM4ZDxf1wDZ6zTJN/VIaaq6NgZGzePt3TXHs9JzA05KLY/mxvMDaCMeR+
         /Kpq979I55Icq8sZV/ewIhyxwWl+rBe6ca1cNzYYdsqPwe7Q4kApQwQEujgRjYVSoB7W
         0fpFt9Sao9t+HiStDZHPF+T+EoVVjy7pINrknfVTMz6mZKFoWprQNdOi86omJaQ5ng2f
         m3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7wq75tjrYjFirFQ74uk4J5adNLKuR7GIvypCoUjFLM=;
        b=I/BwIDGSSvD6XO0lgpELm5NDLUHn997P3XO6NKaG3mfsa5zZbqpB/WrmfF5Y756VLW
         GbaYIoA7ariZ1sB3B9HoJ0h9w1SPDWjUrPFQOuyongPEaatH1aZkYbzA8OEwQ7IoSaER
         hiOu8YqZIw1ktzTBxf1Ik/wem0Yu5BOQP3Z+SCbZb4Sy6g2ANiW3EE44yJoQdG9E8RMA
         jv7vxCd421LMcW1xXXdWnhIfc1+8xFW7XWKV4NdcIe4Mxgd3e4K43a/3gXPlhT2dmqlH
         yXcSkXqEhiOcx2Bc5Kuf0A799u+fQ2/db4A9hLXf348F9yu+FbuhCMnSQ1Z8fCWRsvbk
         0mug==
X-Gm-Message-State: AOAM530c2DF1S72JHdfn3UfOCKDqLKTgLTe2VSf1PGMeUNbAWhPvT1M8
	M/7Qn3HcOePOoC0cAEoL/oX7+44CuF3is8ay6XQ=
X-Google-Smtp-Source: ABdhPJwFk/SDWlg+gkQslqaEmF8VCFPjqc54LKBsRr/o3IGIWqqfmkMgXRdqzdyIc0kBAUt6ieVuTw==
X-Received: by 2002:a17:902:7403:b029:f3:519f:21e with SMTP id g3-20020a1709027403b02900f3519f021emr3217744pll.39.1621347310249;
        Tue, 18 May 2021 07:15:10 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id a190sm11632898pfb.185.2021.05.18.07.15.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:15:09 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 18 May 2021 04:14:40 -1000
Message-Id: <cover.1621347239.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b4acaa314cd8bc86c50e14464ff01c2d110122c4:

  fetch/gitsm: Fix crash when using git LFS and submodules (2021-05-13 13:11:46 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Ross Burton (1):
  providers: selected version not available should be a warning

 lib/bb/providers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

