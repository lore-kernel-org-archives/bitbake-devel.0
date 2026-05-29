Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10AACD6E49
	for <webhook@archiver.kernel.org>; Fri, 29 May 2026 16:46:50 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14849.1780073205474564943
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 May 2026 09:46:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=o9TB/vh7;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso160099036d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 09:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780073204; cv=none;
        d=google.com; s=arc-20240605;
        b=FH7VG7CVvx/HdD9fCLFi5wQemVFuhyhXrqx4/Wu06K162LmkY6H2KvHT2ZXTQHPEjM
         Yy0i6OT5lgwTkNv2oF6QYLpdIcgFyxRopsviqTgFARhmZ3zGsIC8VfZcO0nrf0x0+rK2
         z1eW1RicJomulxmKuRYn46e1MttV1cLK/1e4O7WyRovzhHhnCedE88dDZHH0l16U+6bs
         kQoCv/Gs2joA88OWYzaQlCKOjwXyJubYcPWr1JVrpE8kx+4xWmUk6t9cL/0TO7rS3MqM
         naW18rNSA4Um63+waC+Wq8HsAAcMVbs3+wa7iLo5H1ZYTDJLNaZHFwBMaAVhGqpxb2Vt
         9Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gA7KUCZetNxmlP9J9SsFeL3mWgT4oIdP+/KFvMoRkns=;
        fh=GWExUfJR88oeVCRfRxKHLPc/xMpLE0KqWIH3LUJXQUs=;
        b=jZ6+Oe6it493xXKgH3VZ/BE9lxCN7tXyGbWRCB0X4BNSu+bTfBSMxv/uAGmn3gsE/O
         0mseLJ7CWx2jlwdFZqIWFhKrDhYlypuCeXe7b32R6etI3SHku4lCse5vBiX/+m4k93lz
         2U2M0EnefpRZ2dFtYECOEkF5VJUlPT6Z+uz9SmPt/RFrhsS4ImJ+VWgMVtbHlJyI4OPp
         5/LtHBy184Q3Snop3Qd+pv3xjn0/pWjpK9j6sHtwHdxTvFPKVBGEl1Yh8VxvIadkHF09
         QsHWyq8fmmfM1uq8hakiYJuDGW+wszb9x5wo9AHiWoKLooGxE1cw0LPplXSi+HaQoE8j
         Aa4A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073204; x=1780678004; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gA7KUCZetNxmlP9J9SsFeL3mWgT4oIdP+/KFvMoRkns=;
        b=o9TB/vh7AITPhhk7qU73L98z547HP9ANHaigbTNjxk1RE0tYmqGzQorN0TqeBXBuPQ
         dMcUJcukErQ9XKlZOFnmkYJm6aBlmQrNdCMhn11OvGGSxLu7CcEuTZ0R7PFKTrkrRb9+
         55TAQgtT4NYeVY/03pGRXcX4jUfO2lRuiRt0Q9EsKXcWe+0ls2bUfn+nOi3ufF0gT8+b
         hhdOjPAEHxocKyInmmd64Rhh9DNfpehI6wiOgsJOeZYP0w5MBWPU4/Bjh3OFi63+UUPV
         jqdxJzkACFFlWmB86e9xn/eK4PsbINzYCITW4kAmrQ0P65fglpuCCxiOVkTI8EZFvitB
         72xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073204; x=1780678004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA7KUCZetNxmlP9J9SsFeL3mWgT4oIdP+/KFvMoRkns=;
        b=ZaVfniKQ/sHO1jmxkCOzSOZcQ3JsjWjhHQcusH04UxVG69fsHHvzeRiwgSKx5G07xz
         ORnXmfSeEwRhQMtHfyQ2lF+eyLc/4iFOT9Sg8gF+T+r+fx3o/sWySzCAb0r1XUvELVHm
         va6mWjLH2Oj9kxWi2SBsayt8V0RdX0+eiLzQanTigWU/TCeMeWpW06rByPqx+s5xDk6j
         I42hxmUBpKkw9nCPa29eMBa+Z6ZGRGqItlJHTsSQLd+u9ur4Irhts9gdUJg1doXpWDlw
         irpHvNzwJOqDFCtislbW1bvwDIIIIVeAw16BLL4UUKagZzJMaS80PZL9rqD/5Lp7pulS
         DFCQ==
X-Gm-Message-State: AOJu0Yxx1PKLfbF7AP0rOz1256tfigmPcLg1IeSx7vTJYj/tBzrnReP1
	2wOIxnvMHCJdBCo0GXsMqquLJgtYOiQ9esiogSl3Y3eqt8+k+vE7Fs1phtwpNdpVBX9wOXZ+ANE
	gPMogzBxlzmUk7M+pRSgKDPyea0PlAsY=
X-Gm-Gg: Acq92OGRaKww7HBjtivsrknGMGGBUF8lrUynQsnhXrfeUmVH77wQxhqYe5hu6ODDVOk
	/VOqAOSgPnwgOUFta7nKZt/9N8g/dEJ3nDME/DYziG3OThpc8YrkvNVXZd8fjVUIN6IRHjJcpnR
	w57Ixm91R1VzRDEZNOwhv+gs4qiZcSy6jeFBpoBrZ5erUBH++qnCTao12xEPTbzA5ze3vzGiibH
	fRiiHuuZkgOGgrKpY+oNUn/WIzT60rX/c2UzwnVm9P5TVdXG9uUG0dt+6WZv8R2vq9u8E5ZnV2g
	FZ8hqstymKE38Vyi5s6juhf0Gtvy2vRGLo00Eb8g6Qk3DcAgq6iE
X-Received: by 2002:a05:6214:c6b:b0:89c:806c:93 with SMTP id
 6a1803df08f44-8ccefd8d38cmr7411286d6.30.1780073204501; Fri, 29 May 2026
 09:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-override-improvements-v1-0-91db62e0149e@toradex.com>
 <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
In-Reply-To: <20260529-bb-setup-override-improvements-v1-1-91db62e0149e@toradex.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 29 May 2026 18:46:32 +0200
X-Gm-Features: AVHnY4LUNmkw8V2qeOPTeYd7KVoZcdvgy_ndtU9ulLPwENikSAT4Mz9ngQ-re1I
Message-ID: <CANNYZj_iZGyJQo-OrTXfH1rBSxtrQtOcCT9Mfnb3uiBJpwQL3Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: support multiple
 source override files
To: ernestvanhoecke@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 May 2026 16:46:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19569

On Fri, 29 May 2026 at 16:52, Ernest Van Hoecke via
lists.openembedded.org
<ernestvanhoecke=gmail.com@lists.openembedded.org> wrote:
> The bitbake-setup documentation currently states that:
> "The --source-overrides option can be passed multiple times, in which
> case the overrides are applied in the order specified in the
> command-line."
>
> However, this is not currently true and only the last --source-overrides
> argument is actually used.

To be honest, I'd rather fix the documentation, and avoid increasing
code complexity in the lack of clear use case. It's always possible to
merge multiple jsons into one with a simple python script. This would
also keep things consistent with the 'multiple sets of sources in
json' idea, where you'd only pick one of them.

Alex

