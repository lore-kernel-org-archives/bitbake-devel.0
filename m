Return-Path: <sider123456789101112131415@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3BC3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 13:24:25 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.75677.1746537857152590896
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 May 2025 06:24:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CzubY+7e;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: sider123456789101112131415@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b061a775ac3so5263755a12.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 May 2025 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746537856; x=1747142656; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fEHj6YqQyE/2PtUmhWWwl7qsiIwPOtH9xljJAZTVNI=;
        b=CzubY+7e9Oe9a5HW9bB1Fer7eOJ7GOl53JtHIMwcs9lFKsokXgV8mViDddBNvnJg/W
         v6Ml2HYxDZCV+dNVaM/DLpbqHNHZHZjdDIHpLYXO/to0nugQN2utUeI4kyuPyBk//TVg
         LpvIqyevyHDeg4ztB+i4Craj3yOsOZJGPSpeo1K+zWkHIg2aPzFAU739mnrD+KwRXvIW
         NpYHu6aVo5UK1cOnuYyT1dpakqryfTVmJic7zok9/SHo+UowU5YMCiADT0Ml8qc+On3n
         7/cvoCcZNngH2DJhoVoPviZNteHgmXr+uVdf4TrZGwHj25BRLCkcoxRADZatBbogbZsd
         FFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537856; x=1747142656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fEHj6YqQyE/2PtUmhWWwl7qsiIwPOtH9xljJAZTVNI=;
        b=Jr0j1tLUKCpNGncAH0LACihG1Tt//AVxK1lg5ALtNB91drhbvjTi7DsJh+UlXxEIwZ
         miHr/lU7XeaWlPcc9PNKJYi4npPJ43C4NLU0eK9qwkv5EsaOXJOUnu0umh6aiiNbNnCO
         IOHbkRCjN683xPd8TyVrOZkBw2xThD8MG4YZ9Voj8MI75ehFBQerM/wRLbvGs6eZKONs
         zbPngw7XQL/SeDJRCqFhZZGEfZLN5KZpktjMIEXh2n9l+8X0gHtil7BW2jmB6glOnFN+
         nc2rdJA3ZmMpoVAh7qs2k2eNRY7P+m9CKW6CPxURKVxxEwDZzrPkhjqj8foDK2x+rvR0
         yEWw==
X-Gm-Message-State: AOJu0Yxn/1fL/qN6kcDO8J+pLWOviXRXg/aI8b4hLp88YkD++VMdig3E
	ZJe5l3vt+lyhXElnmwLtwMW3RJnLZVcYIwQqQI7W+aC88lIKYUOVRSj+oyOTzVEAS8wFIkWSO5b
	fEU8aE3VECJlEsfAhZz4S1YHri+T4uyWRBfE07Arg1CI=
X-Gm-Gg: ASbGnct/6sa+gHomyRuoTjQSnx2Kb9GcDFFXOIvqtpEDpL58p8DROKlIuq+DA5kdOPQ
	/K0Oovj3uWygVfkLiZXceLP1vE4RQYb2gx1wdGoAfKLsPMBvvbt2QQxyiGs24Uft3DFPylYkhOh
	Pen4/nACjrpIHGziNVXTNfanM=
X-Google-Smtp-Source: AGHT+IG4ahAnm4xWtS2H9LV2I/v0i8/ryyohO80buec8WTybqg9ntYR8GLA08qb5WuFT0XZ2KoW0+VahRxwM/v4Eznc=
X-Received: by 2002:a17:90b:2dc5:b0:2ff:6608:78cd with SMTP id
 98e67ed59e1d1-30a7c08065dmr4933055a91.9.1746537855588; Tue, 06 May 2025
 06:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
In-Reply-To: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0=?= <sider123456789101112131415@gmail.com>
Date: Tue, 6 May 2025 16:24:03 +0300
X-Gm-Features: ATxdqUHOvnMCyxPJGhv0mgNPAeYT3sFon5qfT4Wq2R_sDItv3wvMk4il0Ci60F4
Message-ID: <CAGCYn1Tpe0OM==H7-9HjbkmCaBZ6Rv7Tr82boWO0y5Qn31DD=Q@mail.gmail.com>
Subject: Re: [PATCH] Speeding up Checking sstate mirror object availability :
 Add async filtering SSTATE_MIRRORS
To: bitbake-devel@lists.openembedded.org
Cc: gavrilov.andrew1999@yandex.ru, tinyakovx@gmail.com, 
	denisova.olga.k@yandex.ru
Content-Type: multipart/alternative; boundary="000000000000781d2c063477885a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 May 2025 13:24:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17596

--000000000000781d2c063477885a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello dear colleagues!

Following the patch letter, I am attaching information about the problem we
found, how we investigated it, how we fixed it and the results of the fix.


As the number of addresses specified in the SSTATE_MIRRORS variable
increases, the duration of the "Checking sstate mirror object availability"
process also increases. This is logical, as the number of addresses to
probe grows. However, it was observed that the "Checking sstate mirror
object availability" process time increases even when SSTATE_MIRRORS
contains one valid address and multiple unreachable addresses.
To validate this observation, a testing system was developed. Two computers
were connected in a local network: one performs the build, while the second
shares the sstate-cache. On the second computer, the sstate-cache is hosted
on a single port. Iterative builds were performed on Computer 1, with
SSTATE_MIRRORS configured to include one valid port and a varying number
(from 1 to 48) of "non-working" servers =E2=80=94 addresses pointing to Com=
puter 2
but with closed ports. Below is an example configuration:
SSTATE_MIRRORS ?=3D " \
file://.* http://10.138.70.7:8150/sstate-cache/PATH;downloadfilename=3DPATH=
 \
file://.* http://10.138.70.7:8151/sstate-cache/PATH;downloadfilename=3DPATH=
 \
file://.* http://10.138.70.7:8152/sstate-cache/PATH;downloadfilename=3DPATH=
 \
file://.* http://10.138.70.7:9999/sstate-cache/PATH;downloadfilename=3DPATH=
"
Here, http://10.138.70.7:9999 hosts a valid sstate-cache server, while
http://10.138.70.7:8150, http://10.138.70.7:8151, and
http://10.138.70.7:8152 are closed ports. The time from the start of the
build to the completion of the "Checking sstate mirror object availability"
process was measured, and the results are visualized in the figure:
https://drive.google.com/file/d/1uFwzDSnD0I_WGAeUyvNXTRb9qIxQBXqN/view?usp=
=3Dsharing

Thus, it can be concluded that increasing the number of addresses in
SSTATE_MIRRORS leads to longer "Checking sstate mirror object availability"
process times, even when those addresses are unreachable.
It is also worth noting that servers can be unavailable for various
reasons, ranging from internal errors to network problems or DDoS attacks -
regardless of the reason, having unavailable servers specified in
local.cong leads to longer build times.

A patch has been implemented that, during the parsing of the local.conf
configuration file, immediately after reading the SSTATE_MIRRORS variable,
attempts to asynchronously establish TCP connections for each address
listed in SSTATE_MIRRORS. If a connection is successfully established, the
address remains in SSTATE_MIRRORS; if the connection attempt fails, the
address is removed from the variable. This ensures that any addresses
unreachable at the TCP level are excluded from subsequent processing.
These modifications are activated only if the FILTER_SSTATE_MIRRORS
variable is set to 1 in local.conf.

The experiment described above was conducted after applying the patch. The
results were recorded and visualized in:
https://drive.google.com/file/d/1vlkjbK20iCVLpYTWhZb08gNbDpXm2_ur/view?usp=
=3Dsharing
As shown in the graph, the address filtering works successfully, and
increasing the number of non-working servers does not lead to longer
Checking sstate mirror object availability process times.
For clarity, the data before and after applying the patch are also
visualized in a logarithmic scale:
https://drive.google.com/file/d/1BKgWtMAlI-39VnTImI8NjNOpE6rIhG-7/view?usp=
=3Dsharing
.



Best regards,
Konstantin E. *Kondratenko*

=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 16:17, Konst=
antinKondratenko <
sider123456789101112131415@gmail.com>:

> As the number of addresses specified in the SSTATE_MIRRORS variable
> increases, the duration of the "Checking sstate mirror object availabilit=
y"
> process also increases.
> This is logical, as the number of addresses to probe grows. However, it
> was observed that the "Checking sstate mirror object availability" proces=
s
> time increases even when SSTATE_MIRRORS contains one valid address and
> multiple unreachable addresses.
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
> Signed-off-by: KonstantinKondratenko <sider123456789101112131415@gmail.co=
m
> >
> ---
>  lib/bb/cookerdata.py | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 1f447d30c2..8b642bdd90 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -305,6 +305,73 @@ class CookerDataBuilder(object):
>
>          bb.codeparser.update_module_dependencies(self.data)
>
> +        if self.data.getVar('FILTER_SSTATE_MIRRORS') =3D=3D '1':
> +            try:
> +                import asyncio
> +                from urllib.parse import urlparse
> +
> +                mirrors =3D self.data.getVar('SSTATE_MIRRORS') or None
> +                if mirrors:
> +                    parts =3D mirrors.split()
> +                    mirrors_list =3D [' '.join(parts[i:i+2]) for i in
> range(0, len(parts), 2)]
> +
> +                def get_default_port(scheme):
> +                    if scheme =3D=3D 'http':
> +                        return 80
> +                    elif scheme =3D=3D 'https':
> +                        return 443
> +                    elif scheme =3D=3D 'ftp':
> +                        return 21
> +                    elif scheme =3D=3D 'ftps':
> +                        return 990
> +                    else:
> +                        return 8888  # Default value for unknown schemes
> +
> +                async def is_port_open(address, port, timeout=3D5):
> +                    try:
> +                        reader, writer =3D await
> asyncio.wait_for(asyncio.open_connection(address, port), timeout)
> +                        writer.close()
> +                        await writer.wait_closed()
> +                        return True
> +                    except (asyncio.TimeoutError, OSError):
> +                        return False
> +
> +                def extract_address_and_port(url):
> +                    parsed_url =3D urlparse(url)
> +                    address =3D parsed_url.hostname
> +                    port =3D parsed_url.port if parsed_url.port else
> get_default_port(parsed_url.scheme)
> +                    return address, port
> +
> +
> +                async def async_mirrors_filter(mirrors_list, data):
> +                    tasks =3D []
> +
> +                    for item in mirrors_list:
> +                        url =3D item.split()[1]
> +                        address, port =3D extract_address_and_port(url)
> +                        if address and port:
> +                            tasks.append(is_port_open(address, port))
> +
> +                    results =3D await asyncio.gather(*tasks)
> +
> +                    if False in results:
> +                        output_string =3D " ".join(
> +                            mirror
> +                            for mirror, result in zip(mirrors_list,
> results)
> +                            if result
> +                            )
> +                        if not output_string:
> +                            logger.warning("All SSTATE_MIRRORS are not
> available")
> +                        else:
> +                            logger.warning(f'Several SSTATE_MIRRORS are
> not available, using: {str(output_string)}!')
> +                        data.setVar('SSTATE_MIRRORS', output_string)
> +
> +                if mirrors:
> +                    asyncio.run(async_mirrors_filter(mirrors_list,
> self.data))
> +
> +            except Exception as e:
> +                logger.error(f"Error checking SSTATE_MIRRORS
> availability: {e}")
> +
>          # Handle obsolete variable names
>          d =3D self.data
>          renamedvars =3D d.getVarFlags('BB_RENAMED_VARIABLES') or {}
>

--000000000000781d2c063477885a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello dear colleagues!<br><br>Following t=
he patch letter, I am attaching information about the problem we found, how=
 we investigated it, how we fixed it and the results of the fix.<br><br><br=
>As the number of addresses specified in the SSTATE_MIRRORS variable increa=
ses, the duration of the &quot;Checking sstate mirror object availability&q=
uot; process also increases. This is logical, as the number of addresses to=
 probe grows. However, it was observed that the &quot;Checking sstate mirro=
r object availability&quot; process time increases even when SSTATE_MIRRORS=
 contains one valid address and multiple unreachable addresses.<br>To valid=
ate this observation, a testing system was developed. Two computers were co=
nnected in a local network: one performs the build, while the second shares=
 the sstate-cache. On the second computer, the sstate-cache is hosted on a =
single port. Iterative builds were performed on Computer 1, with SSTATE_MIR=
RORS configured to include one valid port and a varying number (from 1 to 4=
8) of &quot;non-working&quot; servers =E2=80=94 addresses pointing to Compu=
ter 2 but with closed ports. Below is an example configuration:<br>SSTATE_M=
IRRORS ?=3D &quot; \<br>file://.* <a href=3D"http://10.138.70.7:8150/sstate=
-cache/PATH;downloadfilename=3DPATH">http://10.138.70.7:8150/sstate-cache/P=
ATH;downloadfilename=3DPATH</a> \<br>file://.* <a href=3D"http://10.138.70.=
7:8151/sstate-cache/PATH;downloadfilename=3DPATH">http://10.138.70.7:8151/s=
state-cache/PATH;downloadfilename=3DPATH</a> \<br>file://.* <a href=3D"http=
://10.138.70.7:8152/sstate-cache/PATH;downloadfilename=3DPATH">http://10.13=
8.70.7:8152/sstate-cache/PATH;downloadfilename=3DPATH</a> \<br>file://.* <a=
 href=3D"http://10.138.70.7:9999/sstate-cache/PATH;downloadfilename=3DPATH"=
>http://10.138.70.7:9999/sstate-cache/PATH;downloadfilename=3DPATH</a>&quot=
;<br>Here, <a href=3D"http://10.138.70.7:9999">http://10.138.70.7:9999</a> =
hosts a valid sstate-cache server, while <a href=3D"http://10.138.70.7:8150=
">http://10.138.70.7:8150</a>, <a href=3D"http://10.138.70.7:8151">http://1=
0.138.70.7:8151</a>, and <a href=3D"http://10.138.70.7:8152">http://10.138.=
70.7:8152</a> are closed ports. The time from the start of the build to the=
 completion of the &quot;Checking sstate mirror object availability&quot; p=
rocess was measured, and the results are visualized in the figure:=C2=A0<a =
href=3D"https://drive.google.com/file/d/1uFwzDSnD0I_WGAeUyvNXTRb9qIxQBXqN/v=
iew?usp=3Dsharing">https://drive.google.com/file/d/1uFwzDSnD0I_WGAeUyvNXTRb=
9qIxQBXqN/view?usp=3Dsharing</a>=C2=A0<br>Thus, it can be concluded that in=
creasing the number of addresses in SSTATE_MIRRORS leads to longer &quot;Ch=
ecking sstate mirror object availability&quot; process times, even when tho=
se addresses are unreachable.<br>It is also worth noting that servers can b=
e unavailable for various reasons, ranging from internal errors to network =
problems or DDoS attacks - regardless of the reason, having unavailable ser=
vers specified in local.cong leads to longer build times.<br><br>A patch ha=
s been implemented that, during the parsing of the local.conf configuration=
 file, immediately after reading the SSTATE_MIRRORS variable, attempts to a=
synchronously establish TCP connections for each address listed in SSTATE_M=
IRRORS. If a connection is successfully established, the address remains in=
 SSTATE_MIRRORS; if the connection attempt fails, the address is removed fr=
om the variable. This ensures that any addresses unreachable at the TCP lev=
el are excluded from subsequent processing.<br>These modifications are acti=
vated only if the FILTER_SSTATE_MIRRORS variable is set to 1 in local.conf.=
<br><br>The experiment described above was conducted after applying the pat=
ch. The results were recorded and visualized in:=C2=A0<a href=3D"https://dr=
ive.google.com/file/d/1vlkjbK20iCVLpYTWhZb08gNbDpXm2_ur/view?usp=3Dsharing"=
>https://drive.google.com/file/d/1vlkjbK20iCVLpYTWhZb08gNbDpXm2_ur/view?usp=
=3Dsharing</a><br>As shown in the graph, the address filtering works succes=
sfully, and increasing the number of non-working servers does not lead to l=
onger Checking sstate mirror object availability process times.<br>For clar=
ity, the data before and after applying the patch are also visualized in a =
logarithmic scale: <a href=3D"https://drive.google.com/file/d/1BKgWtMAlI-39=
VnTImI8NjNOpE6rIhG-7/view?usp=3Dsharing">https://drive.google.com/file/d/1B=
KgWtMAlI-39VnTImI8NjNOpE6rIhG-7/view?usp=3Dsharing</a> .<br><br><br></div><=
div><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature"=
 data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div style=3D"color:rg=
b(136,136,136)">Best regards,</div><div style=3D"color:rgb(136,136,136)">Ko=
nstantin E.=C2=A0<b>Kondratenko</b></div></div></div></div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">=D0=B2=D1=82, 6 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 16:17,=
 KonstantinKondratenko &lt;<a href=3D"mailto:sider123456789101112131415@gma=
il.com">sider123456789101112131415@gmail.com</a>&gt;:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">As the number of addresses specified =
in the SSTATE_MIRRORS variable increases, the duration of the &quot;Checkin=
g sstate mirror object availability&quot; process also increases.<br>
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

--000000000000781d2c063477885a--

