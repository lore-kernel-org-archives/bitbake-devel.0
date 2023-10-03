Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331DE7AD76
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 16:05:33 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.112548.1696349131415821274
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 09:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=I/ANowNo;
 spf=pass (domain: snapchat.com, ip: 209.85.208.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so6536917a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1696349130; x=1696953930; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEk8+hR/Di66jExwzcmvMwljHAfUwlBuN3/WeRjuKD8=;
        b=I/ANowNoNIEmNiN8Yx2WfGSFG/pOJVsgKGmxcLdrFkYo0j77TvDpPo7AkyVAkpJAzq
         I5ey5xySfIVZRslkX0Wels2iBKYsfzb7KmzGcoBfkBaxFZX7C9ayWKjExUjFnecsij2n
         jGjIdHBwgHZNmSuqJx4RWWzRQsToos2L8BVIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696349130; x=1696953930;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEk8+hR/Di66jExwzcmvMwljHAfUwlBuN3/WeRjuKD8=;
        b=lpL9O4mjIPIAVmJV5ctLFI/RtCOwAuWCEw6N3hh5m1RJRVLtgOaGkr0t+fV7l7fsCr
         dz0zP4si1dvxDuBi/NEqMX0UiAMXyjk3IiuUQLprjEohV0dobr/UlPs/hzm6GFFdOZHJ
         7uv37ZW9EK5PN9W0oMdqCwhvwfP4LbvgU2CtaABDqrat2iV/jQKGKMZrbwjEiLLUTT4f
         iEeq5wUdUXrKHenEwXAAj98Apl8PNFFLXQQ3DOsWNVf6c3tFoBA9+Dq0DqxHwLy1COHT
         Nakbc+SJLRl6ISrHqVebEe5t6BYPhtEToSCwId8N2JRDH+BVANBby6DRy/tDSxYTUs9k
         qODA==
X-Gm-Message-State: AOJu0YyZGe2b7FIgLtZxRmWrnVUaVX8bbgdv+M9luRHJ6gqbHCqScL5l
	sHLl5Aj4GdoOLE9dR6r7I+g8RbNEKXrdQWxGYc0H1A==
X-Google-Smtp-Source: AGHT+IFltlog2LAeHHv1rdqesOACBuTmWRoSGuHxN78evFY/Rft8+eZC+nD9BnfVSN74HJaljvt5hiJ1FKayOBO3a20=
X-Received: by 2002:a17:906:6a10:b0:9ad:8641:e91b with SMTP id
 qw16-20020a1709066a1000b009ad8641e91bmr2551466ejc.11.1696349129647; Tue, 03
 Oct 2023 09:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230824083109.1821425-1-Markus.Niebel@ew.tq-group.com> <CANPvuR=8-BicdWNHsgmyBAZDHg7Phj9b2vhnzbo_xEaEb09b+Q@mail.gmail.com>
In-Reply-To: <CANPvuR=8-BicdWNHsgmyBAZDHg7Phj9b2vhnzbo_xEaEb09b+Q@mail.gmail.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 3 Oct 2023 18:05:18 +0200
Message-ID: <CAHUKmYZxyNDG2yPQ3-rphzCjCJ=5mV0gA1avwOzdsy60VhtMQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] bitbake-getvar: Add a
 quiet command line argument
To: Jose Quaresma <quaresma.jose@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, bitbake-devel@lists.openembedded.org, 
	oss@ew.tq-group.com, Paulo Neves <ptsneves@gmail.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: multipart/alternative; boundary="0000000000004a2bfd0606d20fa9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 16:05:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15175

--0000000000004a2bfd0606d20fa9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is there a technical issue preventing a merge of the patch, or is it
delayed due to the current workload?

Thanks,
Etienne

On Wed, Sep 6, 2023 at 6:41=E2=80=AFPM Jose Quaresma <quaresma.jose@gmail.c=
om>
wrote:

> Gentle ping.
>
> Jose
>
> Markus Niebel <Markus.Niebel@ew.tq-group.com> escreveu no dia quinta,
> 24/08/2023 =C3=A0(s) 09:59:
>
>> From: Paulo Neves <ptsneves@gmail.com>
>>
>> bitbake-getvar does not have a way to silence bitbake
>> server's logger and that makes the tool hard to use for
>> text processing. This is especially true when one wants to
>> get a bitbake value to be piped to some other utility and
>> instead we get uncontrolled logging messages or warnings
>> together with bitbake's variable value.
>>
>> Example without quiet:
>> bitbake-getvar --value MACHINE
>> NOTE: Starting bitbake server...
>> qemux86-64
>>
>> With quiet:
>> bitbake-getvar --value MACHINE --quiet
>> qemux86-64
>>
>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> (cherry picked from commit af354e975d0b4c26d0e91e3c82946b093bc11b45)
>> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
>> ---
>>  bin/bitbake-getvar | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
>> index 5435a8d7..4a9eb4f3 100755
>> --- a/bin/bitbake-getvar
>> +++ b/bin/bitbake-getvar
>> @@ -25,6 +25,7 @@ if __name__ =3D=3D "__main__":
>>      parser.add_argument('-u', '--unexpand', help=3D'Do not expand the
>> value (with --value)', action=3D"store_true")
>>      parser.add_argument('-f', '--flag', help=3D'Specify a variable flag=
 to
>> query (with --value)', default=3DNone)
>>      parser.add_argument('--value', help=3D'Only report the value, no
>> history and no variable name', action=3D"store_true")
>> +    parser.add_argument('-q', '--quiet', help=3D'Silence bitbake server
>> logging', action=3D"store_true")
>>      args =3D parser.parse_args()
>>
>>      if args.unexpand and not args.value:
>> @@ -35,7 +36,7 @@ if __name__ =3D=3D "__main__":
>>          print("--flag only makes sense with --value")
>>          sys.exit(1)
>>
>> -    with bb.tinfoil.Tinfoil(tracking=3DTrue) as tinfoil:
>> +    with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot args.q=
uiet)
>> as tinfoil:
>>          if args.recipe:
>>              tinfoil.prepare(quiet=3D2)
>>              d =3D tinfoil.parse_recipe(args.recipe)
>> --
>> 2.25.1
>>
>>
>>
>>
>>
>
> --
> Best regards,
>
> Jos=C3=A9 Quaresma
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15014):
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_message_15014&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D28=
o5PCk2_SvEBbgcSr9uFO2XInJr64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&s=3D1N6X7NJd=
qFSuMeDnGQl04v2BtAMrwt-IEDztO_J3m-Y&e=3D
> Mute This Topic:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_mt_100931867_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC=
2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D28o5PCk2_SvEB=
bgcSr9uFO2XInJr64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&s=3DmEgzk6IU8WykrVV08Ko=
z1q1uEH0YZkyqWJmZqD5qsfI&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded=
.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGk=
ICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D28o5PCk2_S=
vEBbgcSr9uFO2XInJr64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&s=3DkdUmyOXc4k-qkWGq=
ZYP-xnO6SqTCMOYbkKpmeB7hnIw&e=3D
> [ecordonnier@snap.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000004a2bfd0606d20fa9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is there a technical issue preventing a merge of the patch=
, or is it delayed due to the current workload?<br><br>Thanks,<br>Etienne</=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, Sep 6, 2023 at 6:41=E2=80=AFPM Jose Quaresma &lt;<a href=3D"mailto:qu=
aresma.jose@gmail.com">quaresma.jose@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><span style=
=3D"color:rgb(0,0,0)">Gentle ping.</span><br style=3D"color:rgb(0,0,0)"><br=
 style=3D"color:rgb(0,0,0)"><span style=3D"color:rgb(0,0,0)">Jose</span><br=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>Markus Niebel &lt;<a href=3D"mailto:Markus.Niebel@ew.tq-group.com" target=
=3D"_blank">Markus.Niebel@ew.tq-group.com</a>&gt; escreveu no dia quinta, 2=
4/08/2023 =C3=A0(s) 09:59:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" targ=
et=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
<br>
bitbake-getvar does not have a way to silence bitbake<br>
server&#39;s logger and that makes the tool hard to use for<br>
text processing. This is especially true when one wants to<br>
get a bitbake value to be piped to some other utility and<br>
instead we get uncontrolled logging messages or warnings<br>
together with bitbake&#39;s variable value.<br>
<br>
Example without quiet:<br>
bitbake-getvar --value MACHINE<br>
NOTE: Starting bitbake server...<br>
qemux86-64<br>
<br>
With quiet:<br>
bitbake-getvar --value MACHINE --quiet<br>
qemux86-64<br>
<br>
Signed-off-by: Paulo Neves &lt;<a href=3D"mailto:ptsneves@gmail.com" target=
=3D"_blank">ptsneves@gmail.com</a>&gt;<br>
Signed-off-by: Alexandre Belloni &lt;<a href=3D"mailto:alexandre.belloni@bo=
otlin.com" target=3D"_blank">alexandre.belloni@bootlin.com</a>&gt;<br>
(cherry picked from commit af354e975d0b4c26d0e91e3c82946b093bc11b45)<br>
Signed-off-by: Markus Niebel &lt;<a href=3D"mailto:Markus.Niebel@ew.tq-grou=
p.com" target=3D"_blank">Markus.Niebel@ew.tq-group.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-getvar | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar<br>
index 5435a8d7..4a9eb4f3 100755<br>
--- a/bin/bitbake-getvar<br>
+++ b/bin/bitbake-getvar<br>
@@ -25,6 +25,7 @@ if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;-u&#39;, &#39;--unexpand&#39;,=
 help=3D&#39;Do not expand the value (with --value)&#39;, action=3D&quot;st=
ore_true&quot;)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;-f&#39;, &#39;--flag&#39;, hel=
p=3D&#39;Specify a variable flag to query (with --value)&#39;, default=3DNo=
ne)<br>
=C2=A0 =C2=A0 =C2=A0parser.add_argument(&#39;--value&#39;, help=3D&#39;Only=
 report the value, no history and no variable name&#39;, action=3D&quot;sto=
re_true&quot;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-q&#39;, &#39;--quiet&#39;, help=3D=
&#39;Silence bitbake server logging&#39;, action=3D&quot;store_true&quot;)<=
br>
=C2=A0 =C2=A0 =C2=A0args =3D parser.parse_args()<br>
<br>
=C2=A0 =C2=A0 =C2=A0if args.unexpand and not args.value:<br>
@@ -35,7 +36,7 @@ if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;--flag only makes sense with =
--value&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)<br>
<br>
-=C2=A0 =C2=A0 with bb.tinfoil.Tinfoil(tracking=3DTrue) as tinfoil:<br>
+=C2=A0 =C2=A0 with bb.tinfoil.Tinfoil(tracking=3DTrue, setup_logging=3Dnot=
 args.quiet) as tinfoil:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.recipe:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tinfoil.prepare(quiet=3D2)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D tinfoil.parse_recipe(=
args.recipe)<br>
-- <br>
2.25.1<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15014): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_15014&a=
mp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D28o5PCk2_SvEBbgcSr9uFO2X=
InJr64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&amp;s=3D1N6X7NJdqFSuMeDnGQl04v2BtA=
Mrwt-IEDztO_J3m-Y&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://ur=
ldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitba=
ke-2Ddevel_message_15014&amp;d=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHva=
bgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3D28o5PCk2_SvEBbgcSr9uFO2XInJr64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&amp;s=
=3D1N6X7NJdqFSuMeDnGQl04v2BtAMrwt-IEDztO_J3m-Y&amp;e=3D</a> <br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_100931867_7048771&amp;d=3DDwIFaQ&amp;c=3D=
ncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsR=
ih1DULJTKUkSGa66m67E&amp;m=3D28o5PCk2_SvEBbgcSr9uFO2XInJr64bYAT2f-8b0pVLcGr=
T6qjQgpWJahSmuCsJm&amp;s=3DmEgzk6IU8WykrVV08Koz1q1uEH0YZkyqWJmZqD5qsfI&amp;=
e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.co=
m/v2/url?u=3Dhttps-3A__lists.openembedded.org_mt_100931867_7048771&amp;d=3D=
DwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonV=
uMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D28o5PCk2_SvEBbgcSr9uFO2XInJr64b=
YAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&amp;s=3DmEgzk6IU8WykrVV08Koz1q1uEH0YZkyqW=
JmZqD5qsfI&amp;e=3D</a> <br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwIFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3D28o5PCk2_SvEBbgcSr9uFO2XInJr64bYAT2f-8b0pVLcGrT=
6qjQgpWJahSmuCsJm&amp;s=3DkdUmyOXc4k-qkWGqZYP-xnO6SqTCMOYbkKpmeB7hnIw&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=
=3DDwIFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbN=
onVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3D28o5PCk2_SvEBbgcSr9uFO2XInJr=
64bYAT2f-8b0pVLcGrT6qjQgpWJahSmuCsJm&amp;s=3DkdUmyOXc4k-qkWGqZYP-xnO6SqTCMO=
YbkKpmeB7hnIw&amp;e=3D</a>=C2=A0 [<a href=3D"mailto:ecordonnier@snap.com" t=
arget=3D"_blank">ecordonnier@snap.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000004a2bfd0606d20fa9--

