Return-Path: <sider123456789101112131415@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C810C5B543
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:24:31 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.13319.1749032666166325446
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 03:24:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MBiIjjIr;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: sider123456789101112131415@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235d6de331fso15642095ad.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 03:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749032665; x=1749637465; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4yOTaIq3xyl5WhTjUJnNCwacasoqhUwTajvF8iP1hrI=;
        b=MBiIjjIraKOPLDVtXDsJAynuaxxvEFJVSTVskALQG7wVRRTvDcZlRTMni7/M9eJHwP
         btlZ0taXUtZssHqA6mdHFtv3r+hhpF8L9NIezZgDsGtjWE4TPyTF3j4vudgwr9jSD2Yi
         xVedeSYPbARNqXU99++UAGDarNmkICGcnSkwO7Kgw/4Aoi2BJVLDAcW5WfnbWkAXqJ82
         GCP9O4WkMaIK8wYiIpvILHX8MHNih+OPofx5lGvBqokyNq76Fu/KBMHVT+P/LOrqluRZ
         mopapHeicanwSVuRu5UCYg+5hbiSbgrNCshoJ9spNmS+blKTMJX0yr1hgOTMzQqqveUD
         XPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032665; x=1749637465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yOTaIq3xyl5WhTjUJnNCwacasoqhUwTajvF8iP1hrI=;
        b=HhdA3q1ivfsGDobeFrvODBwtjdbIsh7VCUJQySkM31wVsBFSar+zCvYsgATXEpzwbX
         ijZZnw8o6Db6cqMVNpHpOqUYkQ2RkxGhvfUFR6QHJT6nmTwjYFxADp8PAMofy/ysSFhl
         USFn0osm+OWx62+nhDI2XL1NsZrI78xFvDK4OFDfrC4sJ5I61doruWKOlLrtsiXc+s0c
         VHTPd4yWRl6zQFgHlRkIZP3n75vtShkoKjmowsTAXYKVtYwO1tQYL+q2fGMwMY1JTyuI
         yK3iQE8mWXwc34IDzouC3KjcWTPaOl0q9e3gux5okASOWy/6Z53wOHDZw4QV6ZuFOLsi
         0mew==
X-Gm-Message-State: AOJu0YwmxNF5IxfcpHCVduW4bXlHkhcUYegMneYqzuFLE+E5YA/mzaJr
	sSxSLF2JQ5LVveHBaitIjIc5QzpCTPPOthFllnwgmhqmICl6RVW/prDhmbj9jvIVMi0Kfm3FJYj
	lrAPXx/kHib8EUiUAJSmRt1d0W4MNpbZ6+oqivyc=
X-Gm-Gg: ASbGnctuciv9knhBx7yNdnhvzwk04Z1PDevQaush2eAmVkPU98vJgBjdxCJSjcaNInn
	2H4sXZMXleQnjSj1s9HcNVe2LDMGyt6k3BQBsbgRSq9B3w/x2ZHw8EyIGoKjTHu7PG6N6Dj2QV1
	HDSODl38jEhkQDdaHfVZR2duxeYubXMZS+
X-Google-Smtp-Source: AGHT+IFES88iAgLCJcUdY6/wgPkTQE8hD/1Jj4g89FKOs1CxQM8nUrzOg7HvfAxUV18ladShYjdkn8n7VcR7Upq159A=
X-Received: by 2002:a17:903:1245:b0:235:f70:fd39 with SMTP id
 d9443c01a7336-235e11291f9mr35797165ad.10.1749032665039; Wed, 04 Jun 2025
 03:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250506131751.93175-1-sider123456789101112131415@gmail.com> <183CF2ED7AD8242A.22941@lists.openembedded.org>
In-Reply-To: <183CF2ED7AD8242A.22941@lists.openembedded.org>
From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0=?= <sider123456789101112131415@gmail.com>
Date: Wed, 4 Jun 2025 13:24:14 +0300
X-Gm-Features: AX0GCFtwMddVqxQFdpAxQFtYwuuD_N7KKKB-2CIId9i3aJkapFwzbmvZoeMEbaw
Message-ID: <CAGCYn1QOFvB=KOUHv9TrxeSRo3LCr-Li7O5LoGOv=_oc9_3S+w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] Speeding up Checking sstate mirror object
 availability : Add async filtering SSTATE_MIRRORS
To: bitbake-devel@lists.openembedded.org
Cc: sider123456789101112131415@gmail.com, gavrilov.andrew1999@yandex.ru, 
	tinyakovx@gmail.com, denisova.olga.k@yandex.ru
Content-Type: multipart/alternative; boundary="000000000000b34a540636bc66c4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 10:24:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17678

--000000000000b34a540636bc66c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good afternoon!
Raising the discussion above because I didn't get a response to a previous
email. Let me know if you are still considering the patch or need to change
anything about it.

Best regards,
Konstantin E. *Kondratenko*

=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 16:24, =D0=
=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=BD=D1=82=D0=B8=D0=BD via lists.openemb=
edded.org
<sider123456789101112131415=3Dgmail.com@lists.openembedded.org>:

> Hello dear colleagues!
>
> Following the patch letter, I am attaching information about the problem
> we found, how we investigated it, how we fixed it and the results of the
> fix.
>
>
> As the number of addresses specified in the SSTATE_MIRRORS variable
> increases, the duration of the "Checking sstate mirror object availabilit=
y"
> process also increases. This is logical, as the number of addresses to
> probe grows. However, it was observed that the "Checking sstate mirror
> object availability" process time increases even when SSTATE_MIRRORS
> contains one valid address and multiple unreachable addresses.
> To validate this observation, a testing system was developed. Two
> computers were connected in a local network: one performs the build, whil=
e
> the second shares the sstate-cache. On the second computer, the
> sstate-cache is hosted on a single port. Iterative builds were performed =
on
> Computer 1, with SSTATE_MIRRORS configured to include one valid port and =
a
> varying number (from 1 to 48) of "non-working" servers =E2=80=94 addresse=
s pointing
> to Computer 2 but with closed ports. Below is an example configuration:
> SSTATE_MIRRORS ?=3D " \
> file://.* http://10.138.70.7:8150/sstate-cache/PATH;downloadfilename=3DPA=
TH
> \
> file://.* http://10.138.70.7:8151/sstate-cache/PATH;downloadfilename=3DPA=
TH
> \
> file://.* http://10.138.70.7:8152/sstate-cache/PATH;downloadfilename=3DPA=
TH
> \
> file://.* http://10.138.70.7:9999/sstate-cache/PATH;downloadfilename=3DPA=
TH"
> Here, http://10.138.70.7:9999 hosts a valid sstate-cache server, while
> http://10.138.70.7:8150, http://10.138.70.7:8151, and
> http://10.138.70.7:8152 are closed ports. The time from the start of the
> build to the completion of the "Checking sstate mirror object availabilit=
y"
> process was measured, and the results are visualized in the figure:
> https://drive.google.com/file/d/1uFwzDSnD0I_WGAeUyvNXTRb9qIxQBXqN/view?us=
p=3Dsharing
>
> Thus, it can be concluded that increasing the number of addresses in
> SSTATE_MIRRORS leads to longer "Checking sstate mirror object availabilit=
y"
> process times, even when those addresses are unreachable.
> It is also worth noting that servers can be unavailable for various
> reasons, ranging from internal errors to network problems or DDoS attacks=
 -
> regardless of the reason, having unavailable servers specified in
> local.cong leads to longer build times.
>
> A patch has been implemented that, during the parsing of the local.conf
> configuration file, immediately after reading the SSTATE_MIRRORS variable=
,
> attempts to asynchronously establish TCP connections for each address
> listed in SSTATE_MIRRORS. If a connection is successfully established, th=
e
> address remains in SSTATE_MIRRORS; if the connection attempt fails, the
> address is removed from the variable. This ensures that any addresses
> unreachable at the TCP level are excluded from subsequent processing.
> These modifications are activated only if the FILTER_SSTATE_MIRRORS
> variable is set to 1 in local.conf.
>
> The experiment described above was conducted after applying the patch. Th=
e
> results were recorded and visualized in:
> https://drive.google.com/file/d/1vlkjbK20iCVLpYTWhZb08gNbDpXm2_ur/view?us=
p=3Dsharing
> As shown in the graph, the address filtering works successfully, and
> increasing the number of non-working servers does not lead to longer
> Checking sstate mirror object availability process times.
> For clarity, the data before and after applying the patch are also
> visualized in a logarithmic scale:
> https://drive.google.com/file/d/1BKgWtMAlI-39VnTImI8NjNOpE6rIhG-7/view?us=
p=3Dsharing
> .
>
>
>
> Best regards,
> Konstantin E. *Kondratenko*
>
> =D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 16:17, Kon=
stantinKondratenko <
> sider123456789101112131415@gmail.com>:
>
>> As the number of addresses specified in the SSTATE_MIRRORS variable
>> increases, the duration of the "Checking sstate mirror object availabili=
ty"
>> process also increases.
>> This is logical, as the number of addresses to probe grows. However, it
>> was observed that the "Checking sstate mirror object availability" proce=
ss
>> time increases even when SSTATE_MIRRORS contains one valid address and
>> multiple unreachable addresses.
>>
>> A patch has been implemented that, during the parsing of the local.conf
>> configuration file, immediately after reading the SSTATE_MIRRORS variabl=
e,
>> attempts to asynchronously establish TCP connections for each address
>> listed in SSTATE_MIRRORS. If a connection is successfully established, t=
he
>> address remains in SSTATE_MIRRORS; if the connection attempt fails, the
>> address is removed from the variable. This ensures that any addresses
>> unreachable at the TCP level are excluded from subsequent processing.
>> These modifications are activated only if the FILTER_SSTATE_MIRRORS
>> variable is set to 1 in local.conf.
>>
>> Signed-off-by: KonstantinKondratenko <
>> sider123456789101112131415@gmail.com>
>> ---
>>  lib/bb/cookerdata.py | 67 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
>> index 1f447d30c2..8b642bdd90 100644
>> --- a/lib/bb/cookerdata.py
>> +++ b/lib/bb/cookerdata.py
>> @@ -305,6 +305,73 @@ class CookerDataBuilder(object):
>>
>>          bb.codeparser.update_module_dependencies(self.data)
>>
>> +        if self.data.getVar('FILTER_SSTATE_MIRRORS') =3D=3D '1':
>> +            try:
>> +                import asyncio
>> +                from urllib.parse import urlparse
>> +
>> +                mirrors =3D self.data.getVar('SSTATE_MIRRORS') or None
>> +                if mirrors:
>> +                    parts =3D mirrors.split()
>> +                    mirrors_list =3D [' '.join(parts[i:i+2]) for i in
>> range(0, len(parts), 2)]
>> +
>> +                def get_default_port(scheme):
>> +                    if scheme =3D=3D 'http':
>> +                        return 80
>> +                    elif scheme =3D=3D 'https':
>> +                        return 443
>> +                    elif scheme =3D=3D 'ftp':
>> +                        return 21
>> +                    elif scheme =3D=3D 'ftps':
>> +                        return 990
>> +                    else:
>> +                        return 8888  # Default value for unknown scheme=
s
>> +
>> +                async def is_port_open(address, port, timeout=3D5):
>> +                    try:
>> +                        reader, writer =3D await
>> asyncio.wait_for(asyncio.open_connection(address, port), timeout)
>> +                        writer.close()
>> +                        await writer.wait_closed()
>> +                        return True
>> +                    except (asyncio.TimeoutError, OSError):
>> +                        return False
>> +
>> +                def extract_address_and_port(url):
>> +                    parsed_url =3D urlparse(url)
>> +                    address =3D parsed_url.hostname
>> +                    port =3D parsed_url.port if parsed_url.port else
>> get_default_port(parsed_url.scheme)
>> +                    return address, port
>> +
>> +
>> +                async def async_mirrors_filter(mirrors_list, data):
>> +                    tasks =3D []
>> +
>> +                    for item in mirrors_list:
>> +                        url =3D item.split()[1]
>> +                        address, port =3D extract_address_and_port(url)
>> +                        if address and port:
>> +                            tasks.append(is_port_open(address, port))
>> +
>> +                    results =3D await asyncio.gather(*tasks)
>> +
>> +                    if False in results:
>> +                        output_string =3D " ".join(
>> +                            mirror
>> +                            for mirror, result in zip(mirrors_list,
>> results)
>> +                            if result
>> +                            )
>> +                        if not output_string:
>> +                            logger.warning("All SSTATE_MIRRORS are not
>> available")
>> +                        else:
>> +                            logger.warning(f'Several SSTATE_MIRRORS are
>> not available, using: {str(output_string)}!')
>> +                        data.setVar('SSTATE_MIRRORS', output_string)
>> +
>> +                if mirrors:
>> +                    asyncio.run(async_mirrors_filter(mirrors_list,
>> self.data))
>> +
>> +            except Exception as e:
>> +                logger.error(f"Error checking SSTATE_MIRRORS
>> availability: {e}")
>> +
>>          # Handle obsolete variable names
>>          d =3D self.data
>>          renamedvars =3D d.getVarFlags('BB_RENAMED_VARIABLES') or {}
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17596):
> https://lists.openembedded.org/g/bitbake-devel/message/17596
> Mute This Topic: https://lists.openembedded.org/mt/112648550/9785696
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> sider123456789101112131415@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000b34a540636bc66c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Good afternoon! <br>Raising the discussio=
n above because I didn&#39;t get a response to a previous email. Let me kno=
w if you are still considering the patch or need to change anything about i=
t.</div><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_s=
ignature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div style=3D=
"color:rgb(136,136,136)">Best regards,</div><div style=3D"color:rgb(136,136=
,136)">Konstantin E.=C2=A0<b>Kondratenko</b></div></div></div></div></div><=
br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=
=B2 16:24, =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=BD=D1=82=D0=B8=D0=BD via=
 <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;s=
ider123456789101112131415=3D<a href=3D"mailto:gmail.com@lists.openembedded.=
org">gmail.com@lists.openembedded.org</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hello de=
ar colleagues!<br><br>Following the patch letter, I am attaching informatio=
n about the problem we found, how we investigated it, how we fixed it and t=
he results of the fix.<br><br><br>As the number of addresses specified in t=
he SSTATE_MIRRORS variable increases, the duration of the &quot;Checking ss=
tate mirror object availability&quot; process also increases. This is logic=
al, as the number of addresses to probe grows. However, it was observed tha=
t the &quot;Checking sstate mirror object availability&quot; process time i=
ncreases even when SSTATE_MIRRORS contains one valid address and multiple u=
nreachable addresses.<br>To validate this observation, a testing system was=
 developed. Two computers were connected in a local network: one performs t=
he build, while the second shares the sstate-cache. On the second computer,=
 the sstate-cache is hosted on a single port. Iterative builds were perform=
ed on Computer 1, with SSTATE_MIRRORS configured to include one valid port =
and a varying number (from 1 to 48) of &quot;non-working&quot; servers =E2=
=80=94 addresses pointing to Computer 2 but with closed ports. Below is an =
example configuration:<br>SSTATE_MIRRORS ?=3D &quot; \<br>file://.* <a href=
=3D"http://10.138.70.7:8150/sstate-cache/PATH;downloadfilename=3DPATH" targ=
et=3D"_blank">http://10.138.70.7:8150/sstate-cache/PATH;downloadfilename=3D=
PATH</a> \<br>file://.* <a href=3D"http://10.138.70.7:8151/sstate-cache/PAT=
H;downloadfilename=3DPATH" target=3D"_blank">http://10.138.70.7:8151/sstate=
-cache/PATH;downloadfilename=3DPATH</a> \<br>file://.* <a href=3D"http://10=
.138.70.7:8152/sstate-cache/PATH;downloadfilename=3DPATH" target=3D"_blank"=
>http://10.138.70.7:8152/sstate-cache/PATH;downloadfilename=3DPATH</a> \<br=
>file://.* <a href=3D"http://10.138.70.7:9999/sstate-cache/PATH;downloadfil=
ename=3DPATH" target=3D"_blank">http://10.138.70.7:9999/sstate-cache/PATH;d=
ownloadfilename=3DPATH</a>&quot;<br>Here, <a href=3D"http://10.138.70.7:999=
9" target=3D"_blank">http://10.138.70.7:9999</a> hosts a valid sstate-cache=
 server, while <a href=3D"http://10.138.70.7:8150" target=3D"_blank">http:/=
/10.138.70.7:8150</a>, <a href=3D"http://10.138.70.7:8151" target=3D"_blank=
">http://10.138.70.7:8151</a>, and <a href=3D"http://10.138.70.7:8152" targ=
et=3D"_blank">http://10.138.70.7:8152</a> are closed ports. The time from t=
he start of the build to the completion of the &quot;Checking sstate mirror=
 object availability&quot; process was measured, and the results are visual=
ized in the figure:=C2=A0<a href=3D"https://drive.google.com/file/d/1uFwzDS=
nD0I_WGAeUyvNXTRb9qIxQBXqN/view?usp=3Dsharing" target=3D"_blank">https://dr=
ive.google.com/file/d/1uFwzDSnD0I_WGAeUyvNXTRb9qIxQBXqN/view?usp=3Dsharing<=
/a>=C2=A0<br>Thus, it can be concluded that increasing the number of addres=
ses in SSTATE_MIRRORS leads to longer &quot;Checking sstate mirror object a=
vailability&quot; process times, even when those addresses are unreachable.=
<br>It is also worth noting that servers can be unavailable for various rea=
sons, ranging from internal errors to network problems or DDoS attacks - re=
gardless of the reason, having unavailable servers specified in local.cong =
leads to longer build times.<br><br>A patch has been implemented that, duri=
ng the parsing of the local.conf configuration file, immediately after read=
ing the SSTATE_MIRRORS variable, attempts to asynchronously establish TCP c=
onnections for each address listed in SSTATE_MIRRORS. If a connection is su=
ccessfully established, the address remains in SSTATE_MIRRORS; if the conne=
ction attempt fails, the address is removed from the variable. This ensures=
 that any addresses unreachable at the TCP level are excluded from subseque=
nt processing.<br>These modifications are activated only if the FILTER_SSTA=
TE_MIRRORS variable is set to 1 in local.conf.<br><br>The experiment descri=
bed above was conducted after applying the patch. The results were recorded=
 and visualized in:=C2=A0<a href=3D"https://drive.google.com/file/d/1vlkjbK=
20iCVLpYTWhZb08gNbDpXm2_ur/view?usp=3Dsharing" target=3D"_blank">https://dr=
ive.google.com/file/d/1vlkjbK20iCVLpYTWhZb08gNbDpXm2_ur/view?usp=3Dsharing<=
/a><br>As shown in the graph, the address filtering works successfully, and=
 increasing the number of non-working servers does not lead to longer Check=
ing sstate mirror object availability process times.<br>For clarity, the da=
ta before and after applying the patch are also visualized in a logarithmic=
 scale: <a href=3D"https://drive.google.com/file/d/1BKgWtMAlI-39VnTImI8NjNO=
pE6rIhG-7/view?usp=3Dsharing" target=3D"_blank">https://drive.google.com/fi=
le/d/1BKgWtMAlI-39VnTImI8NjNOpE6rIhG-7/view?usp=3Dsharing</a> .<br><br><br>=
</div><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div style=3D"color:rgb(136,136,136)">Best regards=
,</div><div style=3D"color:rgb(136,136,136)">Konstantin E.=C2=A0<b>Kondrate=
nko</b></div></div></div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=
=80=AF=D0=B3. =D0=B2 16:17, KonstantinKondratenko &lt;<a href=3D"mailto:sid=
er123456789101112131415@gmail.com" target=3D"_blank">sider12345678910111213=
1415@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">As the number of addresses specified in the SSTATE_MIRRORS variable=
 increases, the duration of the &quot;Checking sstate mirror object availab=
ility&quot; process also increases.<br>
This is logical, as the number of addresses to probe grows. However, it was=
 observed that the &quot;Checking sstate mirror object availability&quot; p=
rocess time increases even when SSTATE_MIRRORS contains one valid address a=
nd multiple unreachable addresses.<br>
<br>
A patch has been implemented that, during the parsing of the local.conf con=
figuration file, immediately after reading the SSTATE_MIRRORS variable, att=
empts to asynchronously establish TCP connections for each address listed i=
n SSTATE_MIRRORS. If a connection is successfully established, the address =
remains in SSTATE_MIRRORS; if the connection attempt fails, the address is =
removed from the variable. This ensures that any addresses unreachable at t=
he TCP level are excluded from subsequent processing.<br>
These modifications are activated only if the FILTER_SSTATE_MIRRORS variabl=
e is set to 1 in local.conf.<br>
<br>
Signed-off-by: KonstantinKondratenko &lt;<a href=3D"mailto:sider12345678910=
1112131415@gmail.com" target=3D"_blank">sider123456789101112131415@gmail.co=
m</a>&gt;<br>
---<br>
=C2=A0lib/bb/cookerdata.py | 67 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 67 insertions(+)<br>
<br>
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py<br>
index 1f447d30c2..8b642bdd90 100644<br>
--- a/lib/bb/cookerdata.py<br>
+++ b/lib/bb/cookerdata.py<br>
@@ -305,6 +305,73 @@ class CookerDataBuilder(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.codeparser.update_module_dependencies(=
self.data)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.data.getVar(&#39;FILTER_SSTATE_MIRRORS=
&#39;) =3D=3D &#39;1&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import asyncio<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from urllib.parse =
import urlparse<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mirrors =3D self.d=
ata.getVar(&#39;SSTATE_MIRRORS&#39;) or None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if mirrors:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part=
s =3D mirrors.split()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mirr=
ors_list =3D [&#39; &#39;.join(parts[i:i+2]) for i in range(0, len(parts), =
2)]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def get_default_po=
rt(scheme):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if s=
cheme =3D=3D &#39;http&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 80<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 scheme =3D=3D &#39;https&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 443<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 scheme =3D=3D &#39;ftp&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 21<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 scheme =3D=3D &#39;ftps&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 990<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 8888=C2=A0 # Default value for unknown schemes<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 async def is_port_=
open(address, port, timeout=3D5):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 reader, writer =3D await asyncio.wait_for(asyncio.open_connectio=
n(address, port), timeout)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 writer.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 await writer.wait_closed()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exce=
pt (asyncio.TimeoutError, OSError):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return False<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def extract_addres=
s_and_port(url):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pars=
ed_url =3D urlparse(url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 addr=
ess =3D parsed_url.hostname<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port=
 =3D parsed_url.port if parsed_url.port else get_default_port(parsed_url.sc=
heme)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn address, port<br>
+<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 async def async_mi=
rrors_filter(mirrors_list, data):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 task=
s =3D []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for =
item in mirrors_list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 url =3D item.split()[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 address, port =3D extract_address_and_port(url)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if address and port:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 tasks.append(is_port_open(address, port))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resu=
lts =3D await asyncio.gather(*tasks)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if F=
alse in results:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 output_string =3D &quot; &quot;.join(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 mirror<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 for mirror, result in zip(mirrors_list, results)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if result<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if not output_string:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning(&quot;All SSTATE_MIRRORS are not av=
ailable&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 logger.warning(f&#39;Several SSTATE_MIRRORS are no=
t available, using: {str(output_string)}!&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 data.setVar(&#39;SSTATE_MIRRORS&#39;, output_string)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if mirrors:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 asyn=
cio.run(async_mirrors_filter(mirrors_list, self.data))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(f&quo=
t;Error checking SSTATE_MIRRORS availability: {e}&quot;)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Handle obsolete variable names<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d =3D self.data<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0renamedvars =3D d.getVarFlags(&#39;BB_REN=
AMED_VARIABLES&#39;) or {}<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17596): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17596" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17596</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/112648550/978=
5696" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/112648550/9785696</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:sider123456789101112131415@gmail.c=
om" target=3D"_blank">sider123456789101112131415@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000b34a540636bc66c4--

