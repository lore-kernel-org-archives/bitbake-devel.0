Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B741C6FA82
	for <webhook@archiver.kernel.org>; Fri, 23 Sep 2022 13:16:43 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.7349.1663939000179369637
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 06:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G1uzfhiV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id n12so20390445wrx.9
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Sep 2022 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date;
        bh=+VW5Ek86Co/h0A4H01PoQ6ZF7gAicufO3KF52bPiSqU=;
        b=G1uzfhiVw+gdTnOk0ttny4CnX1A3sBfH9YHXzUkm+wU44K6+sgnerXHDEIl62Rml1n
         p/QcKv7FjNwUvOFa+fXVexoJ3VhgbLcqFiT3t26AWRAqcy4/J5E/VLMNkHGa8YZMGN/7
         JYjn+xIPOWmbV78+VA0ktdi05VNzqqufW8ua4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=+VW5Ek86Co/h0A4H01PoQ6ZF7gAicufO3KF52bPiSqU=;
        b=El7vgXJfaNo7PRHqTIZHGpT3/a/y7E1M7DodxziCuApTaJRO130BNnGCYiulgQwcLe
         LLI3ci1uSEikaQBgkCruquRMKbYMowPw9D2YDo4yKEnVzqs4haXOhBks4ej+Y/IUXVWu
         QtVq4ApCHxQ9FVBoi/7i+RjeaV/1zJPN4QpBcYc0VJGil2LitKqc9LkNjoIDnpGntOwk
         4KsV8R1YxFPNqkAGPtRBopZYbmH9Ln9FRbqM0YudlCxQK+Kwd6woonQVUCMwrcva356w
         2AZMMin6gSRl/1c2umBVr4dna+Lfi8zQ0C4sYua/TwyUk0ZBrXNASu8BNCPQY0iqXA0/
         lV1g==
X-Gm-Message-State: ACrzQf3ReD4IZfKfoDOGwMqXxqCePS2djLB6uJ7MdP/OPTkJgkTb/eMI
	0RTOvOD/mVtzmGbLuFRSWNZVAA==
X-Google-Smtp-Source: 
 AMsMyM71cL48RCfMNZ9tSydKZyVkhlqgfMEBox1TMw3WU7kIPvqKUqUGSMywjvb5b4DVCu2YpFC/eg==
X-Received: by 2002:a5d:4745:0:b0:228:d9ec:6b5d with SMTP id
 o5-20020a5d4745000000b00228d9ec6b5dmr5322661wrs.257.1663938998353;
        Fri, 23 Sep 2022 06:16:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7946:c7c6:1ddc:ce8e?
 ([2001:8b0:aba:5f3c:7946:c7c6:1ddc:ce8e])
        by smtp.gmail.com with ESMTPSA id
 m187-20020a1ca3c4000000b003a83ca67f73sm2481344wme.3.2022.09.23.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 06:16:37 -0700 (PDT)
Message-ID: 
 <e66ec2ca23ac7ce7e5be44aaacaeb2f6d1ab779b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] utils: Enable the loopback interface in
 disable_network()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2022 14:16:37 +0100
In-Reply-To: <20220923101613.1096056-1-pkj@axis.com>
References: <20220923101613.1096056-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Sep 2022 13:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13990

On Fri, 2022-09-23 at 12:16 +0200, Peter Kjellerstedt wrote:
> From: Mattias Jernberg <mattiasj@axis.com>
>=20
> This allows, e.g., gRPC within the host to be used even when
> networking is disabled.
>=20
> Signed-off-by: Mattias Jernberg <mattias.jernberg@axis.com>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>=20
> In our case, we have a wrapper for make (bear from
> https://github.com/rizsotto/Bear) that is automatically enabled when
> externalsrc is used. This creates a compile_commands.json file, which,
> e.g., VS Code can make use of. The problem here is that bear uses gRPC
> to communicate with itself and this does not work when all network
> communications are disabled. Enabling the loopback interface resolves
> this problem.
>=20
>  bitbake/lib/bb/utils.py | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 92d44c5260..2d37c50bac 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -29,6 +29,8 @@ import collections
>  import copy
>  import ctypes
>  import random
> +import socket
> +import struct
>  import tempfile
>  from subprocess import getstatusoutput
>  from contextlib import contextmanager
> @@ -1603,6 +1605,41 @@ def set_process_name(name):
>      except:
>          pass
> =20
> +def loopback_up():
> +    # From bits/ioctls.h
> +    SIOCGIFFLAGS =3D 0x8913
> +    SIOCSIFFLAGS =3D 0x8914
> +    SIOCSIFADDR =3D 0x8916
> +    SIOCSIFNETMASK =3D 0x891C
> +
> +    # if.h
> +    IFF_UP =3D 0x1
> +    IFF_RUNNING =3D 0x40
> +
> +    # bits/socket.h
> +    AF_INET =3D 2
> +
> +    # char ifr_name[IFNAMSIZ=3D16]
> +    ifr_name =3D struct.pack("@16s", b"lo")
> +    def netdev_req(fd, req, data =3D b""):
> +        # Pad and add interface name
> +        data =3D ifr_name + data + (b'\x00' * (16 - len(data)))
> +        # Return all data after interface name
> +        return fcntl.ioctl(fd, req, data)[16:]
> +
> +    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO=
_IP) as sock:
> +        fd =3D sock.fileno()

> +        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t =
sin_port ; uint32_t in_addr; }
> +        req =3D struct.pack("@H", AF_INET) + struct.pack("=3DH4B", 0, 12=
7, 0, 0, 1)
> +        netdev_req(fd, SIOCSIFADDR, req)

> +        # short ifr_flags
> +        flags =3D struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))=
[0]
> +        flags |=3D IFF_UP | IFF_RUNNING
> +        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))


> +        # struct sockaddr_in ifr_netmask
> +        req =3D struct.pack("@H", AF_INET) + struct.pack("=3DH4B", 0, 25=
5, 0, 0, 0)
> +        netdev_req(fd, SIOCSIFNETMASK, req)
> +

I found that quite hard to read/understand, it would probably help to
put some whitespace between the netdev requests. Using those kinds of
structs is pretty horrible but I guess there isn't much else we can do
about it. Having the code in bitbake and hence made available via a
function is probably better than the alternatives.

>  def disable_network(uid=3DNone, gid=3DNone):
>      """
>      Disable networking in the current process if the kernel supports it,=
 else
> @@ -1626,6 +1663,10 @@ def disable_network(uid=3DNone, gid=3DNone):
>      if ret !=3D 0:
>          logger.debug("System doesn't suport disabling network without ad=
min privs")
>          return
> +
> +    # Enable the loopback interface
> +    loopback_up()
> +
>      with open("/proc/self/uid_map", "w") as f:
>          f.write("%s %s 1" % (uid, uid))
>      with open("/proc/self/setgroups", "w") as f:

I think I'd probably prefer just to leave networking disabled and then
allow places where it is specifically needed to add loopback back. You
could probably do that in externalsrc where you add the bear
dependency?

Cheers,

Richard



