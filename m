Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3706.1795466166089342993
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Nov 2026 12:36:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=SWdd8c/G;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so29872845e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Nov 2026 12:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466164; x=1796070964; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMPSm1dEP7K4wcgvGt+Jvq+sRbPG/G8ic/M+wLTAqFo=;
        b=SWdd8c/G4l+SGVdDsIYyg/EWKHpzu9lZo0O6IlYGa0ryZqsM8MfMtWJPNmHgcd2ppZ
         4wMAZr6AW+HonIF8DA0tIHLn79dWQjnvf80G8nK2nPuPRyCvrqGbAtKGQjEWKWQZAb8E
         O0oxbMIHZfoM7GegyAZ6qR4/ta7XsBkfDYyU1Pb9f3sZ2m/SjQSRs7mC84jLWmunGtx5
         DDci7f1YPVpBIVba7wX2Ycc9ZdpnV2JpUEyjGomqtLCoIjpZLgknBksL2S8LH0mzlfNd
         ZxgF94MDxeY3lUMV0vQJ2bRRVUxJCOhKcKV71MJnfCSTDzIzGQo7XFDy0LXoTERarpjK
         HaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466164; x=1796070964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LMPSm1dEP7K4wcgvGt+Jvq+sRbPG/G8ic/M+wLTAqFo=;
        b=Q7tDdbtl1B2i2sB9Fo8ne17iFgOf5hpGV2YgVSwiSa2AkCfLqi/szapHxctPGVXfhf
         /TWwXXlWLjHrov5qfLirJIv3JNPnXRazvR5Wf95C4ELSv5u1g4hCoMjhLhH7rGouUr7A
         kENE0TRkKflXmgzc+7nRtNbRKtOzwzUVi6iMZYfo8u352PNYyGuwjCEXn3chgA8lK0Ax
         /9WWaO6xZV/63AarHmekUW1Uc4iE5zHqvItoKzFGOQs6cre9v0VN1ObsqYMC8YCCRzZO
         MkAhoIYy1VhQWchrbW9tvIjeM6VHWa3bVWGU8YAaE4o2GXIVPXxLIpWPw+VNcpcn3V0e
         1j8Q==
X-Gm-Message-State: APuU4Z8+5GEA53zRZVIZDRWBpJE0D6yQgi0v5GyDoiV6ioDtAjzXvY6t
	/EURP0wBvQbgpHuZNPZOM2MVluZm9xtNK9pmo+rwAPwXvdve26vMUZ25
X-Gm-Gg: AZFdTZcuCZRc2GHajRWItjZIrKzt/mQ3cJjB394Tu+ijw49n6xeq14/SBbnNfqNHUbt
	/lPiAH8luARrmDCKb/ozlB46vqtbwQx+QuSG5r8Zr8Sy2H3ozpSXcpvq8b0J7mZ6RAr07pOtOIK
	mahZxDxgUmKo08bvr9QojFoUx4dlUsyTO/jacEQ48hR/TPnNrwAJLvwfd2ctsy/+pu9+WDg7OCk
	zt3a5QYVLRiGx3kgu7eaCnJZyKsljupu4nwhR7nxmXSHRgxzS0tKdIlsbdAr61A/ZuBWVGCm6hq
	zFjCJNv061IwoS7GonY8wDWGkoU9pMyipV8YQUGyfpr9+x4okQAQEOg/bCmdmIqudgYcn/046ZE
	N7lhy+znWo3+ARx8xXD7dirWysT6th+Sx0c6S3I7s4aV9hKo52FbGX3q/hTy4m24AN5ACKzpo58
	Z37CEvXouOvPeqaESEDEImva0y7QSTnceKvYfSCygHP2YaTvoxG8rI7l4/h3bYVYWzK131Xp2/g
	N4iGkWARDQ3W8qRd8MBS/zt51x/GJkrnHZFeSbakF57UiofGWECqmJ1hVjo1XYPnP+rVrwryV9z
	ixEGy3LyrYHqOa09tYL0E9iAGf+mmT2k
X-Received: by 2002:a05:600c:470a:b0:4a1:d459:db4b with SMTP id 5b1f17b1804b1-4bb8893071fmr261310315e9.24.1795466164085;
        Mon, 23 Nov 2026 12:36:04 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b3a7sm427874685e9.3.2026.11.23.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:36:02 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
	Thomas Perrot <thomas.perrot@bootlin.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: Re: [bitbake-devel] [PATCH 1/2] cooker: Write variables that are not JSON types to the event log
Date: Mon, 23 Nov 2026 21:36:01 +0100
Message-ID: <20261123203601.867088-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <196178d920291fb292393e16233869c08f077760.camel@linuxfoundation.org>
References: <20261120135323.2627478-1-stondo@gmail.com> <20261120135323.2627478-2-stondo@gmail.com> <196178d920291fb292393e16233869c08f077760.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 23 Nov 2026 20:36:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20471
Content-Type: text/plain; charset="utf-8"

On Fri, 2026-11-20 at 18:46 +0000, Richard Purdie wrote:
> This worries me a bit (well, a lot!), specifically the "second build"
> piece. Why is this persisting across builds? Does:
>
> https://git.openembedded.org/bitbake/commit/?id=606786d17351534ce35d1b0f89815461546a66fe
>
> have any effect on that?

Hi Richard,

606786d17 does not change it. The value persists in the cooker
datastore, not in the global context.

RunQueueExecute.check_dependencies() calls BB_SETSCENE_DEPVALID with
d set to self.cooker.data. In OE-Core, setscene_depvalid() in
sstate.bbclass caches the compiled patterns of
SSTATE_EXCLUDEDEPS_SYSROOT in that datastore:

    d.setVar('_SSTATE_EXCLUDEDEPS_SYSROOT', excludedeps)

Nothing removes the variable. So it stays in the datastore until the
cooker parses the configuration again. I checked this with tinfoil on
master: after two builds of nodejs-native:do_populate_sysroot in one
server, config_data still contains the list.

The value alone does not break the event log, because
getAllKeysWithFlags() writes str(v). The crash comes from the
variable history. When tracking is on while setscene_depvalid() runs,
the history records the list, and json.dumps() fails on it at the
start of the next build. Tinfoil(tracking=True) normally enables
tracking only around parsing. But _data_tracked_if_enabled() has no
try/finally, so tracking stays on when the operation inside it raises
an exception. On master, without this patch, the second build fails
with the TypeError in two cases:

- tracking is enabled for the whole tinfoil session
- an exception occurs inside _data_tracked_if_enabled(), and then two
  builds run

I must also correct my cover letter for the OE-Core series. It says
that the recipetool selftest needs this patch. With the final version
of that series, the selftest passes without it. The crash occurred
with an earlier version of my recipetool changes, and I could not
find out which call left tracking on in that run.

I think that these are the correct fixes:

1. sstate.bbclass keeps the compiled patterns out of the datastore.
   With this change in OE-Core, both cases above pass, and the
   variable is not in the event log. setscene_depvalid() gives the
   same results as before.
2. _data_tracked_if_enabled() disables tracking in a finally block.
   With only this change, the case with the exception passes.

I can send both patches. Do you want to keep this patch as a safety
net for other values in the datastore, or should I drop it? Patch 2/2
does not depend on it.

Best regards,
Stefano
