Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12152.1795693395743205858
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Nov 2026 03:43:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YV6oqORH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so40023825e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Nov 2026 03:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1795693394; x=1796298194; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M3YYxbCkpVr7S2pNMjVNs95E6+9CCCOnCsjkEvfBnhw=;
        b=YV6oqORHspQsECOSYk5uJnvN6iZNaTg35uuZnz6eaNKK+CU+4hkq9/RqFIwoHxQPUX
         kTzVIe1+q7EXiaKBVjPCOjGD/B/K9HxfI/S7yjBod7LNaU0N80LojSUkJn3Ebzcj8bv3
         qLmgkCyWTgdv+OXGySdDbo0+ayZo+fHA/D6k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693394; x=1796298194;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3YYxbCkpVr7S2pNMjVNs95E6+9CCCOnCsjkEvfBnhw=;
        b=D53oJ5nmnIomEubYFmYf9aAXbwcYl9sIWvFA4Q5ltU+YmXF/QKWhCuTFBkicqPoTK2
         bX4a6OIeZGVnOvt/LpCStdxUGj4mjT9/jsTdCyjq3XEms+VdLCfldbMwZYs9dqkh7ChY
         1uaUATWWBJYRYrgFVRHaGaw1XZoVXI/6CVe0chV9qSkQNQza9GJ2gv1MVKHwF+Cp5bqk
         yxXbJZewWbCofGlWnPatmVsGTv/eamRCCfbZtNQjDNYogCOo6oRW4EUMmDdFqbsgOO1i
         rE1kIYt4Wo8kt4zNU0IM1Z7P50otd7pzqurFUkVCAt3TzKxmJkQy7kjsiZrEFMb4LnP5
         ebJg==
X-Forwarded-Encrypted: i=1; AL+hErFdCku+Rfn335RmDE/4ip36xu0BF/qOiVODXSYcJN/eLCnry+D+RQCnj924avy/dWQmMeAvz4r9QuuISRKp@lists.openembedded.org
X-Gm-Message-State: APuU4Z/OG4s7/Qj5DOX36JyUJirBdnaI9TUKncYVy5ECs9EDxWJ91gqg
	ux/oUVg5UUlTiwoaHmLwvZmNIHN+lhY21hVLCCXxNqxD+WE3QAfrydoCtXM72DsZodM=
X-Gm-Gg: AZFdTZdHxC6BFl29L/gvs+0yA9RDQeampLx/ePabLaPBfKtFWJuxhSrPVf+USEzCaOH
	xiYtviBey/fVGTBG3Dztvkit1e/f5RpYfaz9vjZBe7rjoXVULVT+dnSbrU+XZxHbd2WNOdPsZUc
	hEJDr0DbGwLFNXlUTkuY0DstArCrfcu1+5afshv5hzrlYbcEZjhKwBS/KaJzdF+QFHbnswq0aNi
	z33FHFAhaY8uz0n2Erf3hi0Dxc4HCtIZexoCHiYWFscKwOM15cFO2kb8M4/4Dur7CDI5aopNH0/
	harbR3H11LVSTXCT/1s5PtohxX8vR1P7A+9WV5Nn/lvoIAVB2H0Ti5K/NTWX8uounjgQbyB2H6B
	SaUvql/FaFYOnnu3Pa+rVYYuqhLCX2hIby/T9UMQcwUVL1tZ4pzFRVCPYruDNCzTbKt9zFqZf8I
	lIJ+rQ/6NrDJTl3R1MFEO9WU7qBARdP8j5oTEwEIIW9B/qUuMhrUpL7qFsGBNwIUcG2XNOc1T4z
	hlxNt87Ortd383QrzJpGPuYAomfTh8Zb2oXJjOlC1z4fqSUWvb48nGjUj0zYqnhTHe5UEdMX6z6
	buclIP/OVfNJuA0mI/8mt85a8JFLRmBF1fXJZsZvVdaj460kvfxQg4S+XIwczkZTem4xn3q5MtF
	lPj7uO4DYr4eJ68C1qA==
X-Received: by 2002:a05:600c:4e8e:b0:4ba:59fa:510e with SMTP id 5b1f17b1804b1-4bb8893014dmr423506205e9.23.1795693393885;
        Thu, 26 Nov 2026 03:43:13 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:cc5e:2b3b:eecc:9402? ([2001:8b0:aba:5f3c:cc5e:2b3b:eecc:9402])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm1101288705e9.4.2026.11.26.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 03:43:12 -0800 (PST)
Message-ID: <612a317dd789706ab5004659fd8af42c01b0b2b0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] gitsm fetcher fails when `PREMIRRORS_ONLY` is
 set
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: tiago.mlb.vasconcelos@gmail.com, bitbake-devel@lists.openembedded.org
Date: Thu, 26 Nov 2026 11:43:11 +0000
In-Reply-To: <1257714.1795630418946145913@lists.openembedded.org>
References: <9Kec.1795097583791318314.gZXu@lists.openembedded.org>
	 <c5c653afd21314dc7d58248102fd23633fec54b6.camel@linuxfoundation.org>
	 <1100827.1795430135720488922@lists.openembedded.org>
	 <1257714.1795630418946145913@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 26 Nov 2026 11:43:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20477

On Wed, 2026-11-25 at 10:13 -0800, tiago.mlb.vasconcelos via bitbake-devel =
wrote:
> Is there any extra information I can provide to help solve this
> issue?

I'm in the middle of implementing some major architecture changes and I
need to think really carefully about those so I'm afraid this kind of
change is taking a lower priority for me right now. We don't have many
other people with the review bandwidth for gitsm.

I appreciate this isn't the answer you'd like :/.

I did see your test case and really appreciate having it as when I do
find time to look at this, it will help a lot.

Cheers,

Richard

