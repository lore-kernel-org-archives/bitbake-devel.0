Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.731.1792792642564234622
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Oct 2026 14:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=TuQPvDY7;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=jhD17TyP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLvH8Q886187
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLq+QqjYilLTlbbRakE1kR6Qe4uyWzjdxzU6DnrTBME=; b=TuQPvDY7PhCRDEKz
	mCO6WZPUjGrGwyKGfCIhjCNHEqyk6Zsojpmt0N7TjqGUv2WxEdYSnVVvBiveUCPU
	H9+uU9xGAA+wJMrV2KAYZsTR7GsmHL8WG6U8cH5hEuVUbkKMPnSvoVGE8dn7FBlr
	kAjnB54sh4d5DWMBZ22ilfAKIlPfLGDzq3A6EItwn+jEL0hwFQgL+xPdLKwEiNLK
	k3cHALogBMcODVGT9ea9wJVX5svyYWduBdNEra3ho9Avt9FeBmEr1bFexZl7HUF5
	hz9pPm6g4pTXh1dm4yx9nodQrv58a+XBEh3yaLv+S50DYXp/mHI0BdXHrKmk1Sey
	K4R/Hg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw2253-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:57:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so1181399b3a.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 14:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792792641; cv=none;
        d=google.com; s=arc-20260327;
        b=AMw/JOMTG/0bvO3tmg04Om7j0x7ln6cnsW5gHTZ6CMQREgLW2LpVb8v2Jtqv7QdwuF
         HnYpiwGan8R+ckJWMn159vRkx4OioDzxDFAvyz/3hxKs2+ee5ene31QanUVb2r9IOCwr
         6NfsrLd4tADh0JX91/kAYKlYcHg7StnkSC2y6E2tEPGw8719lOdYIXAL8DO1gi+9JVhl
         l6uqlEZOtwrFB2GD9RQZhTpaBaB+gc5ErY5D9dw3gyKjIBKpLhqYEJ5UH43ejhdFqJWb
         99vq+pW6hk0vXF/6kZgTOrTTs9aZ5DLWwB8Xh1pUaMIMFFt4z065S7QEkPK0gr+vQhMT
         eaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLq+QqjYilLTlbbRakE1kR6Qe4uyWzjdxzU6DnrTBME=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=WDAvRBvmsRlIKmVRPfQcLEpAkAuSw+LCDFjct4dg7Gr+zPjDX5fKyew+vDln6PSnIP
         x74f9ajx7Mjki88kdBGqqCDxscZjh+UOaDBxNRJlOKO+eZR/jAedEXBOpDz4wf1XdbKP
         MBr+d7c4CK84iXyQsDcqHveXIUML7ni7bJqrdrPwYH/EXpA5BQMxOV8Rs+VfZLqmIPMs
         A6gaoeVDhwHcBk9AmMtcoXx7qplHkx/LOVy8KLV5h62giBMFRIfXKzPBIoVRA5QBQVq9
         4HgTfgWEIpcWVfaUK+DNXP9m0rQ43GeoIJstM1swNPoaXW9A6qM5I5q31ARAcMEivw6s
         Sl0A==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792792641; x=1793397441; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLq+QqjYilLTlbbRakE1kR6Qe4uyWzjdxzU6DnrTBME=;
        b=jhD17TyPCT922u2QUwTTHuaE2/dRGNGMk5zVGlSIJ20kVUo1fkbInT1vRqbH76vQrc
         9eX/wP9dAcBp4+2LAjs9AB+0tySLjmZ1NQYFcMe34Zq8vPDlk+oVPqbl02xzllrfmw1n
         rY3QbjAk5KUiJQI0ljRUywjDs0jBy3ZIXINFkA6f3LKULjdHqYqXW8jmUEb8+Fc4/VR6
         GjbtmjBqXta/ezWf6KW1mXuQSpO4P2AAH8xKVVcaPyU1VKvNbLRtYTwt2gZTnwQc4OIi
         aa+SB1jY5BiIO1nsmSvAd6GRPUxmm3w2k3zeJUBJbjBP7xyR7aioQESAWsSVIkMkBjRZ
         dDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792641; x=1793397441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLq+QqjYilLTlbbRakE1kR6Qe4uyWzjdxzU6DnrTBME=;
        b=CVgX/QqTJ9nK9wBbIO53fEylvEg5UQagGdOY+YoUKo+ZihfZHOm8B8pZnzGYcAn7fK
         U3sVZqpYdBYjVmXYzJy/nrPlPjHCqd2zIilTGUSuoHID+j7IcO3prqK/ZSnJAF3H/lbL
         P52/9KUX4qte32VkLWVsp7AHZD46nYz9FzWGF5mGMud+r+pZ4JEQec4bwL2s1DGGnYUB
         KFRYzYH9nrGgVO1T4ixq2GS9Hao2WP6OMvm+ww6ENdrtKSCJCHJAPjGWXz2c90NopchA
         U+DqyVPQYvobFTcgr90/E/lKTj3MVS7YajwxjjnqrL8tEX13qHNGki2018e4mGlVm6+q
         Jzpg==
X-Gm-Message-State: AFq9FYKlO4wCitXrJXW8HG1GOG8NU0PnT6rMgZLj/Vc5uFkCPXf6dUa7
	6is5NdaWDFfiujW1CJegZsNOgiyghNxllkk2TGDunYiHK/E3bjyzlzwolYVOtM7TrBluLm1XhJN
	tMCtovPDGp892FyzWEWTOLyDts7SpGZI5c8QqAIIa0cnB/lSml4pI+11AINWhlPEYqezz4vrhCp
	7FpSEi7yc5glA1rTM2aSDH0GYH/sZmOeaG990xZ4A3aBnwLhNztqyp
X-Gm-Gg: AYBFou2j8PppeFBC02HwJ88WA52dxMcbIQPNdXqJpIR82E3IQOqUAo8geRuCn7Ze8Jt
	yxVoJfMGUCGhi+SZZ+Wy7ij+r+ms7JvfA5Vts4CFU0tgtkF7uaF7Yx1JnuJYxx4W7+HPknHC4xY
	wJWrA9OaGwKCtz3UgdzUXWOa7oZjZMYRyKyXZ7hCukLAvwWdkWr5W8G6GfjEc=
X-Received: by 2002:a05:6a00:a115:b0:886:5f48:3fca with SMTP id d2e1a72fcca58-8a36705f295mr432245b3a.37.1792792641013;
        Fri, 23 Oct 2026 14:57:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:a115:b0:886:5f48:3fca with SMTP id
 d2e1a72fcca58-8a36705f295mr432235b3a.37.1792792640404; Fri, 23 Oct 2026
 14:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261022225148.2195453-1-ricardo.salveti@oss.qualcomm.com> <ac0c3b89244bc513a59405f476b76bd7bcaca74b.camel@linuxfoundation.org>
In-Reply-To: <ac0c3b89244bc513a59405f476b76bd7bcaca74b.camel@linuxfoundation.org>
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:56:43 -0300
X-Gm-Features: AclHuK-kvuxEHUTb2RPgn28-OiM7Mssb3FemWRIy-3Lf2eoQ1N1qKmzPhBdJUWY
Message-ID: <CAA_5yoti1_wqCPauoGZ5UUV8ZMcLYOwjsvxCE0O8_GymLY1ndA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Avoid building task set unions
 in next_buildable_task
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: ypOOVgpfksug9eTn6KuzH8i8_GDN0pAa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4NiBTYWx0ZWRfX+iHIwQ1BwqKl
 sIGdtsBBgGBbuKlLdNuJ7sFJ5fEyyqHOJGZ05ylim7NQyczAp+BrDJBiNF5RdSh6xAXCtVBnyWj
 cZfXaV+o6EcrhJ38hitcf2fYEw+cVzA=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adbd841 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=ag1SF4gXAAAA:8 a=Q4-j1AaZAAAA:8 a=EUspDBNiAAAA:8
 a=pwv6nNbCc9xOOZLwXUEA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-GUID: ypOOVgpfksug9eTn6KuzH8i8_GDN0pAa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4NiBTYWx0ZWRfXwGor7y4uWAj7
 0ghKCZueFaWLrKRblYLsR30MEX35apSZryG3kS+b1RudTY0Y0ulC1jODNcJf645+8fSIQsELPHb
 ANCZYKNnJboSbIFeVgUm2ZcS09JCrCjw2YR7ulX28/Uh1e7Jj/mqeFRzGjinuxT7EFLBw+5qx87
 deQ+1KPqUelzfDD63XNlCoI6JRvtAhFl1KAtnoljoY8HUVB/heHKwmjIlARIw2EF4pQ+l7v2K6g
 eYOIaJXfBiijN+UqDt6oBC/wqC+EqDNMfZSM7HUJfUd23tzpJYr4/X1XuU9clPF9Evkoom+qbeh
 jYw0sZMegEe4KukRw6Ag2fzS/2h/yFApYSbwkux6TtHQKqY2+o+INSPR8TXukw4P4VdLgLqDjPk
 gcEfsryAxrfuDEiFRIq5qISXzdtXeJE4+i51VxG8ZMk5eRRzyP+JksTSUpRNqEE9xXUdv/i1FiQ
 JO4o1Xt2LpVcU3OUVIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230086
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 23 Oct 2026 21:57:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20371

On Thu, Oct 22, 2026 at 8:10=E2=80=AFPM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Thu, 2026-10-22 at 19:51 -0300, Ricardo Salveti via lists.openembedded=
.org wrote:
> > next_buildable_task() runs at least once for every task in the build,
> > and again on every worker wakeup while a slot is free. Each call copies
> > the buildable set, removes holdoff_tasks from it and intersects it with
> > tasks_covered | tasks_notcovered, and when a task is buildable it also
> > computes runq_running - runq_complete. Those sets grow to the size of
> > the whole runqueue, so every call costs time proportional to the build,
> > although only a small fraction of the tasks are buildable at any time.
> >
> > Filter the buildable tasks by membership instead, and keep
> > runq_running - runq_complete as a set which is updated when tasks start
> > and complete. Tasks are never removed from runq_running or
> > runq_complete, so the new set always equals the difference and, as
> > before, includes failed tasks. Also use it for the thread count in the
> > pressure and load average messages. Every task has its own priority, so
> > the chosen task does not depend on set iteration order.
> >
> > A no-op 'bitbake core-image-minimal' with OE-core goes from 7.66s to
> > 6.64s, and a no-op build of an image with 18 layers from 46.54s to
> > 41.59s (median of 5 runs each). Task signatures and the runqueue task
> > order of dry runs and of a single-threaded build from sstate are
> > unchanged.
> >
> > AI-Generated: Uses Claude Code (Claude Opus 5.5)
> > Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> > ---
> >  lib/bb/runqueue.py | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
>
> I'm torn. That speed up is relatively small compared to times of
> overall builds and it comes at the cost of having two data structures
> in parallel which need to be in sync with each other. We're tried to
> avoid having duplicate data where possible due to the risks that
> entails...
>
> Is that gain really worth it?

Yeah, that's fair. This came out of a wider look at where bitbake
spends its time, and I agree that this could cause additional
maintenance pain, so did another round without the extra set. The
running - complete difference is only needed for number_threads, so v2
reads those flags once when the scheduler is set up and skips the
difference unless some task actually has a limit, which nothing in
oe-core sets today. I also extended it to add a selftest for
number_threads, since that path had no test coverage.

Will send the v2.

Thanks,

Ricardo
