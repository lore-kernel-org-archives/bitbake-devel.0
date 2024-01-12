Return-Path: <roro.cui@broadcom.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8E9C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 16:40:54 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web11.12029.1705077653059383241
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jan 2024 08:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@broadcom.com header.s=google header.b=QxScoxOB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: broadcom.com, ip: 209.85.167.41, mailfrom: roro.cui@broadcom.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e67e37661so8949751e87.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705077650; x=1705682450; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gx0pLoR6g1Qmnji+lQ1w43PlK5YLI5prFbDbcMjgIOE=;
        b=QxScoxOB9I6Z3uOuBfBypCX47nzWk72kM0XIlYA6ni+eyoaUOrSK7A+1WSP08ySf7f
         91cat0yFTpFwjbAx3wmq6S9GME4LET9XPKbCehQiZwJCbH63fbM/P40v46NoSTtZPir8
         TgHqHzz7kOVT60wbjqBArKT3ygEZnb/K8FStc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705077650; x=1705682450;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gx0pLoR6g1Qmnji+lQ1w43PlK5YLI5prFbDbcMjgIOE=;
        b=tOcsE+IhzhGhpx54Gy2Z+4A7TqvKW3jDnI/tc9piRrbOGoBS9s76ryPSW7yhx9xymB
         lcAwdYalLoP70V/FPuiLmpQBxI/Gqr5p3SrBTLgDMXa1P0MmeaKdvUjecn7TiBQH7DOS
         +EhbfXUO0iw8sv6e9UC06ziqHIjoTmHMZ7g7qWsDyVKi9URSsGxQDHyD/hhD2pay3AIi
         tzBy72UhTq9LCnzvgQHVbTjxV243knSR96CwbBJEsttuGlPNu/oQnP00KGq09mu5sxki
         agNVQvy8SxQaMB5CX3VCF/HSGXBXA53nzGjlzAhj5So54X9bZcL9+ONaZsUEUhy5BB73
         +nmw==
X-Gm-Message-State: AOJu0Yykjn9RKnh5Wsz84+IdrtwgJo5ilAto8dboi+XeY/WqWd1RNXTK
	Tx7Xy67QhzmPlN0W/hIXG+q4f5P525hf1zAaWSuVjNiC8DxNCG36zrJTchA5F6dHBJ5BtZu1Xq5
	pkGLGPUkM4R4dnzufbJbsPWFd8VzyW+DdZtlmpzsZfq0ntCedpm/RyQq0W5RKlA==
X-Google-Smtp-Source: AGHT+IER5a98mOz04abpekUiuWPi0IJjnmmjwsiJKLVLirnrnh07/bzExlgNVNmGcH7U4tSX5tHkit6katO6LLWnt8c=
X-Received: by 2002:a05:6512:ea0:b0:50e:8eff:3980 with SMTP id
 bi32-20020a0565120ea000b0050e8eff3980mr1056112lfb.30.1705077649766; Fri, 12
 Jan 2024 08:40:49 -0800 (PST)
MIME-Version: 1.0
From: Roro Cui <roro.cui@broadcom.com>
Date: Fri, 12 Jan 2024 11:40:38 -0500
Message-ID: <CAHBa6FM=C=yZYEVY8yp_j8rXkZ2Fq=n-4b78N2uiFS7=6rgpOw@mail.gmail.com>
Subject: Got "ValueError: filedescriptor out of range in select" on bitbake v1.46.0
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ad6375060ec25380"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jan 2024 16:40:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15789

--000000000000ad6375060ec25380
Content-Type: multipart/alternative; boundary="000000000000a15d8e060ec2536b"

--000000000000a15d8e060ec2536b
Content-Type: text/plain; charset="UTF-8"

hi, Dear Sir or Madam

I hit this issue when building the target in yocto dunfell on our new
server(512 cpu cores)
The cooker daemon process quits abnormally. Here is the output





























*Command CompletedRunning command ['getVariable', 'BBINCLUDELOGS']Command
CompletedRunning command ['getVariable', 'BBINCLUDELOGS_LINES']Command
CompletedRunning command ['getSetVariable', 'BB_CONSOLELOG']Command
CompletedRunning command ['getSetVariable', 'BB_LOGCONFIG']Command
CompletedRunning command ['getUIHandlerNum']Command CompletedRunning
command ['setEventMask', 1, 20, {'BitBake.RunQueue.HashEquiv': 19,
'BitBake.SigGen.HashEquiv': 19}, ['bb.runqueue.runQueueExitWait',
'bb.event.LogExecTTY', 'logging.LogRecord', 'bb.build.TaskFailed',
'bb.build.TaskBase', 'bb.event.ParseStarted', 'bb.event.ParseProgress',
'bb.event.ParseCompleted', 'bb.event.CacheLoadStarted',
'bb.event.CacheLoadProgress', 'bb.event.CacheLoadCompleted',
'bb.command.CommandFailed', 'bb.command.CommandExit',
'bb.command.CommandCompleted', 'bb.cooker.CookerExit',
'bb.event.MultipleProviders', 'bb.event.NoProvider',
'bb.runqueue.sceneQueueTaskStarted', 'bb.runqueue.runQueueTaskStarted',
'bb.runqueue.runQueueTaskFailed', 'bb.runqueue.sceneQueueTaskFailed',
'bb.event.BuildBase', 'bb.build.TaskStarted', 'bb.build.TaskSucceeded',
'bb.build.TaskFailedSilent', 'bb.build.TaskProgress',
'bb.event.ProcessStarted', 'bb.event.ProcessProgress',
'bb.event.ProcessFinished']]Command CompletedRunning command ['setConfig',
'cmd', 'fetch']Command CompletedRunning command ['buildTargets',
['quilt-native'], 'fetch']Command CompletedProcess
ProcessServer-1:Traceback (most recent call last):  File
"/usr/lib/python3.8/multiprocessing/process.py", line 315, in _bootstrap
self.run()  File
"/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib/bb/server/process.py",
line 115, in run    ret = self.main()  File
"/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib/bb/server/process.py",
line 232, in main    ready = self.idle_commands(.1, fds)  File
"/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbake/lib/bb/server/process.py",
line 334, in idle_commands    return
select.select(fds,[],[],nextsleep)[0]ValueError: filedescriptor out of
range in select()Var <PATH[:=]>:1: SyntaxWarning: "is not" with a literal.
Did you mean "!="?*

Is this a known issue?

Thank you.
-- 

Regards

Roro Cui

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000a15d8e060ec2536b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi, Dear Sir or Madam<div><br></div><div>I hit this issue =
when building the target in yocto dunfell on our new server(512 cpu cores)<=
/div><div>The cooker daemon=C2=A0process quits abnormally. Here is the outp=
ut</div><div><br></div><div><i><font color=3D"#00ff00">Command Completed<br=
>Running command [&#39;getVariable&#39;, &#39;BBINCLUDELOGS&#39;]<br>Comman=
d Completed<br>Running command [&#39;getVariable&#39;, &#39;BBINCLUDELOGS_L=
INES&#39;]<br>Command Completed<br>Running command [&#39;getSetVariable&#39=
;, &#39;BB_CONSOLELOG&#39;]<br>Command Completed<br>Running command [&#39;g=
etSetVariable&#39;, &#39;BB_LOGCONFIG&#39;]<br>Command Completed<br>Running=
 command [&#39;getUIHandlerNum&#39;]<br>Command Completed<br>Running comman=
d [&#39;setEventMask&#39;, 1, 20, {&#39;BitBake.RunQueue.HashEquiv&#39;: 19=
, &#39;BitBake.SigGen.HashEquiv&#39;: 19}, [&#39;bb.runqueue.runQueueExitWa=
it&#39;, &#39;bb.event.LogExecTTY&#39;, &#39;logging.LogRecord&#39;, &#39;b=
b.build.TaskFailed&#39;, &#39;bb.build.TaskBase&#39;, &#39;bb.event.ParseSt=
arted&#39;, &#39;bb.event.ParseProgress&#39;, &#39;bb.event.ParseCompleted&=
#39;, &#39;bb.event.CacheLoadStarted&#39;, &#39;bb.event.CacheLoadProgress&=
#39;, &#39;bb.event.CacheLoadCompleted&#39;, &#39;bb.command.CommandFailed&=
#39;, &#39;bb.command.CommandExit&#39;, &#39;bb.command.CommandCompleted&#3=
9;, &#39;bb.cooker.CookerExit&#39;, &#39;bb.event.MultipleProviders&#39;, &=
#39;bb.event.NoProvider&#39;, &#39;bb.runqueue.sceneQueueTaskStarted&#39;, =
&#39;bb.runqueue.runQueueTaskStarted&#39;, &#39;bb.runqueue.runQueueTaskFai=
led&#39;, &#39;bb.runqueue.sceneQueueTaskFailed&#39;, &#39;bb.event.BuildBa=
se&#39;, &#39;bb.build.TaskStarted&#39;, &#39;bb.build.TaskSucceeded&#39;, =
&#39;bb.build.TaskFailedSilent&#39;, &#39;bb.build.TaskProgress&#39;, &#39;=
bb.event.ProcessStarted&#39;, &#39;bb.event.ProcessProgress&#39;, &#39;bb.e=
vent.ProcessFinished&#39;]]<br>Command Completed<br>Running command [&#39;s=
etConfig&#39;, &#39;cmd&#39;, &#39;fetch&#39;]<br>Command Completed<br>Runn=
ing command [&#39;buildTargets&#39;, [&#39;quilt-native&#39;], &#39;fetch&#=
39;]<br>Command Completed<br>Process ProcessServer-1:<br>Traceback (most re=
cent call last):<br>=C2=A0 File &quot;/usr/lib/python3.8/multiprocessing/pr=
ocess.py&quot;, line 315, in _bootstrap<br>=C2=A0 =C2=A0 self.run()<br>=C2=
=A0 File &quot;/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/=
bitbake/lib/bb/server/process.py&quot;, line 115, in run<br>=C2=A0 =C2=A0 r=
et =3D self.main()<br>=C2=A0 File &quot;/local/home1/rorocui/yocto/gr_ml_20=
240105/openembedded-core/bitbake/lib/bb/server/process.py&quot;, line 232, =
in main<br>=C2=A0 =C2=A0 ready =3D self.idle_commands(.1, fds)<br>=C2=A0 Fi=
le &quot;/local/home1/rorocui/yocto/gr_ml_20240105/openembedded-core/bitbak=
e/lib/bb/server/process.py&quot;, line 334, in idle_commands<br>=C2=A0 =C2=
=A0 return select.select(fds,[],[],nextsleep)[0]<br>ValueError: filedescrip=
tor out of range in select()<br>Var &lt;PATH[:=3D]&gt;:1: SyntaxWarning: &q=
uot;is not&quot; with a literal. Did you mean &quot;!=3D&quot;?</font></i><=
br><div><br></div><div>Is this a known issue?=C2=A0</div><div><br></div><di=
v>Thank you.</div><span class=3D"gmail_signature_prefix">-- </span><br><div=
 dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><p><a name=3D"SignatureSa=
nitizer_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter__M=
ailAutoSig">Regards</a></p>

<p>Roro Cui</p>

<p><br><br></p></div></div></div></div></div></div>

<br>
<span style=3D"background-color:rgb(255,255,255)"><font size=3D"2">This ele=
ctronic communication and the information and any files transmitted with it=
, or attached to it, are confidential and are intended solely for the use o=
f the individual or entity to whom it is addressed and may contain informat=
ion that is confidential, legally privileged, protected by privacy laws, or=
 otherwise restricted from disclosure to anyone else. If you are not the in=
tended recipient or the person responsible for delivering the e-mail to the=
 intended recipient, you are hereby notified that any use, copying, distrib=
uting, dissemination, forwarding, printing, or copying of this e-mail is st=
rictly prohibited. If you received this e-mail in error, please return the =
e-mail to the sender, delete it from your computer, and destroy any printed=
 copy of it.</font></span>
--000000000000a15d8e060ec2536b--

--000000000000ad6375060ec25380
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQYQYJKoZIhvcNAQcCoIIQUjCCEE4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg24MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUAwggQooAMCAQICDAN9LtIg9wUJa4XITTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE3NDhaFw0yNTA5MTAxMjE3NDhaMIGG
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xETAPBgNVBAMTCFJvcm8gQ3VpMSQwIgYJKoZIhvcNAQkBFhVy
b3JvLmN1aUBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDf/qwZ
ggSfLkSyPfKBNev1UQEpj69AxDofK9DQ00znW8oAp3ydFPks0E/Z9YhnGUqp4HiZBCVWGdksEjP5
dcFssrBdTkP9sn0gqefU1sGsWgDEO0sB+l+K6CEu/vZXBjaUPqF4BovW+H4O3gRTGlL4enC1ojO2
WM3CW++7vGhrcHvrIy24ZZAu1gOy3wWO3zspGwXkZQX/+wB7dYGTVJF344p4yz8VV6ZyUAto3KXc
6g8M+5FzwNOK8qABWIyvERn++IHszr6VRP1DOYIrKwcTXIdySMKVC8b2+/X/vrd4aEjjylm4L1YI
ic+Ru0PW1DGoP4SOz/cI6JgqCb5g3k0zAgMBAAGjggHWMIIB0jAOBgNVHQ8BAf8EBAMCBaAwgaMG
CCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6
Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARG
MEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNv
bS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xv
YmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCAGA1UdEQQZMBeBFXJv
cm8uY3VpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9Hm
WBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUmt4+vg6vfWGlo4s+xhg/uIUXh6QwDQYJKoZIhvcN
AQELBQADggEBAAi6Tce8RlyLWDyiQb8zI5Bz7VN/nzRzHaERhpEegBGo+APfi3eBlHM3txsQBfGS
BPi3so4niNcrPbsXOrDkd15IHO6kETWkosJR8LFGLgbPeYQliEoFMznplpq8Qmf7MNq4+VFfQ1E5
kDsy3X7Prqaqaetff5GjI2Ttnvv0mWlxwLFOz/HzBSzWp9YneFG45IKXp4yRSQDjb9USiCSnXNdq
86IUPvItGIdoyuLF1vVoa4XXlPaY7b+L2R7ZL8o1qiSbdK0JdZtjAKbAMeVMt8G0MWLWjl32KJ/f
fo+2QPus07NLVJ7qItYjlECi8rdFCLKMPwBsJSWHgElBqRp8bNAxggJtMIICaQIBATBrMFsxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWdu
IEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwDfS7SIPcFCWuFyE0wDQYJYIZIAWUDBAIB
BQCggdQwLwYJKoZIhvcNAQkEMSIEIK4Gq+3vWtHqg4yBnwphy2qS4j7XRR8Uzl+yQu5q8CIgMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDExMjE2NDA1MFowaQYJ
KoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggq
hkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0B
AQEFAASCAQAlnG+7zrAMK2nYgXTDWZh1F77kqbucOTabx5hMhsvp7zmQ+cngvPsSgfhvnShVMabN
uFzqhTUbO9z62dJOLA8G9v9qg5VLnnscfrmuAxiKrPcOlYQ17zy5VzRCqngRLo9AuKQdPTUaOKM0
/e4Fa5f0+oT+mfEPX/5XmEreFVKFx2L6r50ko5EwTs6pp9s6YpN7Z/iHbOAWPfvDdrJpqTD4waH2
Kw7K3WRPPFc0Z3m+S1pCntgfdxYDyoSkRK0/gjAjT16Ey1UCM/8XLFlMgEYBHrEcNdDp5ZdRlU3J
yFVnqrmqC2Sj09b4LbBlJHXt1M9tRANbA6yYmbINeiIQRt3O
--000000000000ad6375060ec25380--

