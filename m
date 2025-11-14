Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E67DCDE013
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:29:07 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12133.1763101738259499838
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:28:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jYw4HvgP;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8826b83e405so22966926d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763101737; x=1763706537; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nkf4M7HxvqCg9p/d+4F6ppKKbvvKkBk2CJaHwW6iXhw=;
        b=jYw4HvgPeyX/zvbLw6UQkIA3JVft02cCLBmwsPuO7PQcp8ZlpuHDgnEqwGTyUevDWn
         2yzwCVI1aTwEN0A1W+7gS2OBx55KpXz8WmeFIhFILULLNjBEckz+w0MouVght2lFYCIn
         cFJC0B5yINEwGuhDmsvuEqo1gNIFjnPewwndhBho/PYFqB4Sy1k8BZvpl3pBIQx8WpOY
         gt1CwQRzI1aGWjqUNUgo5JH7JK9Irr6UShJyom3YKStugNDe9rWjv8jkNdGwvKAdGuZc
         URkCDEq5CfeXnlMRV6ldzUR8AVq2F73X0P80EBm26DSpGUTxWRHVPuphHtCiU8ohZErD
         QA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763101737; x=1763706537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkf4M7HxvqCg9p/d+4F6ppKKbvvKkBk2CJaHwW6iXhw=;
        b=W56kO3cQ6nBAqbC53O+nXUQUbDW6JC2aoDvYq+3xrqE08f0Xgh1ljwhLSBNZMgWLgY
         uDJjsjLurIuAEF2zgzj+sy/HffwgkT6T6sUjQGPZ9DLWzZXP633oE0h3uPjM5Vn0Lxru
         Lt4M8Q2dfxa20aLHS+9Dvl54ZgHskDVNRQMgfG+PuveKqXWQUUVWMQXMhsbbry8pq6RQ
         ZRI+Hm2k6Fuhvc63w8Xl03FN+zPCj+1bNZsDIwCmqCRLACj4sdUfVztWKy6VtJSfgi38
         bOGt0s/ii/QIEnxiYYR2/FAWoI8dhyf6ryfEkPWdaiZEN/o15yUq7R5CUnjqfADyAqp/
         HveA==
X-Gm-Message-State: AOJu0Yz3MVWZgh4So6NVHEgSjw+B6FwkDqkDy2jmK1Kzty+uSNPHwPXp
	o+xl1qjSRR0/8GwrmDkXcSwh/SX1TPGQgRmfmCFHokp/e96X3BnBfrPbALSqKBmLusw/+l9oK9/
	1PXlCmwlQKK1E4dcnEk+EcxZ5YoWrIFg=
X-Gm-Gg: ASbGncujxgbkPMzTGpMkL7zlWWK1tNaeJ9TPpz7ktddZpvnKiV2hiKp/rH0wAZ154SG
	9U9MiY/Easmpf1Nw0VZutUF+G47bFNSC+sVr2xGLJ58LigJRxah84I1RKkcEjoKCtNXTIOYH0Q9
	3zq0kVCjtRDY1BLABHYAEHuuXQe03Cxog0JkJtfd8XUCjMO3NvUnWRav5Q3bd3FkdMmvVSXItWw
	TlKW9SbNiQqPlAhi1yP1zg+Jn85c0lb/faPyjBaADpu8IdBCqNbhlSYW1y7+gOG/GDuHrVJG+zC
	dKnoULDFa7WtnxriwHRXW8sZy9mZAc5o4vq0TrqP
X-Google-Smtp-Source: AGHT+IGiVL7LbQFTQkY7EquP/X45VlzirqwUMcMQEj7C03py75OCClgs+IdjKEqPklCV58bfnC1/7xgDSCdONqctHq8=
X-Received: by 2002:a05:6214:27cc:b0:880:51b9:e8b2 with SMTP id
 6a1803df08f44-8829270bd30mr23968686d6.48.1763101737155; Thu, 13 Nov 2025
 22:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com> <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
In-Reply-To: <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 07:28:46 +0100
X-Gm-Features: AWmQ_bmdx6xaK1RzySQiQDtpccOv0O1suJAkogAFmMhGVcte3xxJl_DLqqorMX4
Message-ID: <CANNYZj8tDk8izGO2f_8ADHsaN9VudG_hsQrcw2N2O8NnXtdCCQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:29:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18384

On Fri, 14 Nov 2025 at 07:20, ChenQi <Qi.Chen@windriver.com> wrote:
> I know that the env method is a horrible hack. I looked around but could not find any other choice. Do you have any suggestion?

I don't understand why the special exception in bitbake-config-build
is needed to begin with. What is the scenario where it is necessary?

Alex

