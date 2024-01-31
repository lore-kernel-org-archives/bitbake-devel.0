Return-Path: <fbberton@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D5C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 08:49:16 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.10027.1706690949314571738
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Jan 2024 00:49:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WAVAyBD+;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: fbberton@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b01484cd7so431335f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 00:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706690947; x=1707295747; darn=lists.openembedded.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsTDZqnsA53tSjPODvt389c1dM/ICHj3QU6mYzBNEOg=;
        b=WAVAyBD+2r7nMFkTV1WADz90Rh7uVPLGfh7HSmDLFGg7ZBWyOTflet61BI8BNX+zmT
         NF7azXjercpW062uHHnSy7D3XQcw7l8LAxNksVz2UFjIBBHBYQT+suCcJGSUNAk6LXiO
         fHgvakXv1uodudCFK/eNtZ7l0hehlQQzgd1m72xGSm5zuLT3zXatLaQtUwpvzPt8nKmd
         o9w7pF9wxySR3d4s/8875HWo9vtjvLJpKS9fBSuHtv30Wty2LGDJwfVGjowqSSNiWai/
         1eDmySApxmPxPetc67fgY5ggnBvivzmHEMHczcn1mUvrt4xt8T+SGP0V58N6e/mfLmlc
         6zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690947; x=1707295747;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsTDZqnsA53tSjPODvt389c1dM/ICHj3QU6mYzBNEOg=;
        b=qx/9XogTabEKB9FgXHAA4Hlxgr4SSWWj6D37DgfbviWTvS2CvGJJWicHoCqtf9znxf
         Ne8xkQS/rpGPPNh4VNoURIMQvzdoKSFm7k0umoQ13ocETN6S+uueOT4NusfzM0gMms4L
         EmVBEDr6Kr3wls34j61i0LV0p5dfVGx2ZpAHVZnjuWFH08elSEdIsmsFq5uuF55kVmNn
         7V22PwjCuHgK6r+I9nyrbO39YrMnHR1O3o48jnPfOpa2jAGKpUz614ySDF36Wp1lp+u3
         nEObYYVB64/cmPcfa/zvbIo4dwrkigpSKiN738S0zA3aGMI1HxiQ8xFAsIWoWMikVStg
         3XHQ==
X-Gm-Message-State: AOJu0Yyl0aHHJ4k8WfImCrHRL1/4dRlXg0N+Y0U9r8T4e9Mn8/uep90p
	taoH9a7jIqkuS2DvfRPIzVqHSd9EoU3fHIdVddkGwPGOkXM0rraKbaE3ASjX
X-Google-Smtp-Source: AGHT+IFESO0V4cBlJM2ffzQCyJKrA3jXqIb5O6xlPR4i26Y8tcCva0C0VjrMU/tPgyvTlGRsRMy6IA==
X-Received: by 2002:adf:ea0d:0:b0:33a:fc8c:1dab with SMTP id q13-20020adfea0d000000b0033afc8c1dabmr578862wrm.67.1706690947080;
        Wed, 31 Jan 2024 00:49:07 -0800 (PST)
Received: from [10.190.5.29] ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033af5086c2dsm5440926wrb.58.2024.01.31.00.49.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:49:06 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------L468iJR5KWY5vCKgqQ4mCEj6"
Message-ID: <9c14808b-798a-48d2-89ab-0e74483d26f3@gmail.com>
Date: Wed, 31 Jan 2024 08:49:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][kirkstone][2.0][PATCH] utils: Add
 enable_loopback_networking()
To: bitbake-devel@lists.openembedded.org
References: <20240109100753.147890-1-fabio.berton@criticaltechworks.com>
Content-Language: en-US
From: Fabio Berton <fbberton@gmail.com>
In-Reply-To: <20240109100753.147890-1-fabio.berton@criticaltechworks.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 08:49:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15815

This is a multi-part message in MIME format.
--------------L468iJR5KWY5vCKgqQ4mCEj6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!
Can this patch be backported to Kirkstone or is it a change that cannot 
be backported?

Thanks

On 1/9/2024 10:07 AM, Fabio Berton via lists.openembedded.org wrote:
> From: Mattias Jernberg<mattiasj@axis.com>
>
> It can be used to enable the loopback interface, typically after calling
> disable_network().
>
> Also correct a typo in a debug message.
>
> Signed-off-by: Mattias Jernberg<mattias.jernberg@axis.com>
> Signed-off-by: Peter Kjellerstedt<peter.kjellerstedt@axis.com>
> Signed-off-by: Richard Purdie<richard.purdie@linuxfoundation.org>
> (cherry picked from commit 0d317209d4234c5f05a9fcdc13c52f502f104018)
> Signed-off-by: Fabio Berton<fabio.berton@criticaltechworks.com>
> ---
>   lib/bb/utils.py | 42 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 3f7f82d1..d09e1782 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -30,6 +30,8 @@ import collections
>   import copy
>   import ctypes
>   import random
> +import socket
> +import struct
>   import tempfile
>   from subprocess import getstatusoutput
>   from contextlib import contextmanager
> @@ -1627,6 +1629,44 @@ def set_process_name(name):
>       except:
>           pass
>
> +def enable_loopback_networking():
> +    # From bits/ioctls.h
> +    SIOCGIFFLAGS = 0x8913
> +    SIOCSIFFLAGS = 0x8914
> +    SIOCSIFADDR = 0x8916
> +    SIOCSIFNETMASK = 0x891C
> +
> +    # if.h
> +    IFF_UP = 0x1
> +    IFF_RUNNING = 0x40
> +
> +    # bits/socket.h
> +    AF_INET = 2
> +
> +    # char ifr_name[IFNAMSIZ=16]
> +    ifr_name = struct.pack("@16s", b"lo")
> +    def netdev_req(fd, req, data = b""):
> +        # Pad and add interface name
> +        data = ifr_name + data + (b'\x00' * (16 - len(data)))
> +        # Return all data after interface name
> +        return fcntl.ioctl(fd, req, data)[16:]
> +
> +    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_IP) as sock:
> +        fd = sock.fileno()
> +
> +        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t sin_port ; uint32_t in_addr; }
> +        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 127, 0, 0, 1)
> +        netdev_req(fd, SIOCSIFADDR, req)
> +
> +        # short ifr_flags
> +        flags = struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))[0]
> +        flags |= IFF_UP | IFF_RUNNING
> +        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))
> +
> +        # struct sockaddr_in ifr_netmask
> +        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 255, 0, 0, 0)
> +        netdev_req(fd, SIOCSIFNETMASK, req)
> +
>   def disable_network(uid=None, gid=None):
>       """
>       Disable networking in the current process if the kernel supports it, else
> @@ -1648,7 +1688,7 @@ def disable_network(uid=None, gid=None):
>
>       ret = libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
>       if ret != 0:
> -        logger.debug("System doesn't suport disabling network without admin privs")
> +        logger.debug("System doesn't support disabling network without admin privs")
>           return
>       with open("/proc/self/uid_map", "w") as f:
>           f.write("%s %s 1" % (uid, uid))
> --
> 2.25.1
>
> The information in this communication may contain confidential or legally privileged information. It is intended solely for the use of the individual or entity it addresses and others authorized to receive it. If you are not an intended recipient, you are hereby notified that any disclosure, copying, distribution or action in reliance on the contents of this information is strictly prohibited and may be unlawful. If you have received this communication by error, please notify us immediately by responding to this e-mail and then delete it from your system. Critical TechWorks is not liable for the proper and complete transmission of the information in this communication nor for any delay in its receipt
>
> This e-mail is environmentally friendly, just like Critical TechWorks, which lives in a paper-free atmosphere. Therefore, please consider the environment before printing it!
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15757):https://lists.openembedded.org/g/bitbake-devel/message/15757
> Mute This Topic:https://lists.openembedded.org/mt/103617369/6083838
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [fbberton@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
--------------L468iJR5KWY5vCKgqQ4mCEj6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p>Hi!<br>
      Can this patch be backported to Kirkstone or is it a change that
      cannot be backported?</p>
    <p>Thanks<br>
    </p>
    <div class="moz-cite-prefix">On 1/9/2024 10:07 AM, Fabio Berton via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:20240109100753.147890-1-fabio.berton@criticaltechworks.com">
      <pre class="moz-quote-pre" wrap="">From: Mattias Jernberg <a class="moz-txt-link-rfc2396E" href="mailto:mattiasj@axis.com">&lt;mattiasj@axis.com&gt;</a>

It can be used to enable the loopback interface, typically after calling
disable_network().

Also correct a typo in a debug message.

Signed-off-by: Mattias Jernberg <a class="moz-txt-link-rfc2396E" href="mailto:mattias.jernberg@axis.com">&lt;mattias.jernberg@axis.com&gt;</a>
Signed-off-by: Peter Kjellerstedt <a class="moz-txt-link-rfc2396E" href="mailto:peter.kjellerstedt@axis.com">&lt;peter.kjellerstedt@axis.com&gt;</a>
Signed-off-by: Richard Purdie <a class="moz-txt-link-rfc2396E" href="mailto:richard.purdie@linuxfoundation.org">&lt;richard.purdie@linuxfoundation.org&gt;</a>
(cherry picked from commit 0d317209d4234c5f05a9fcdc13c52f502f104018)
Signed-off-by: Fabio Berton <a class="moz-txt-link-rfc2396E" href="mailto:fabio.berton@criticaltechworks.com">&lt;fabio.berton@criticaltechworks.com&gt;</a>
---
 lib/bb/utils.py | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3f7f82d1..d09e1782 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -30,6 +30,8 @@ import collections
 import copy
 import ctypes
 import random
+import socket
+import struct
 import tempfile
 from subprocess import getstatusoutput
 from contextlib import contextmanager
@@ -1627,6 +1629,44 @@ def set_process_name(name):
     except:
         pass

+def enable_loopback_networking():
+    # From bits/ioctls.h
+    SIOCGIFFLAGS = 0x8913
+    SIOCSIFFLAGS = 0x8914
+    SIOCSIFADDR = 0x8916
+    SIOCSIFNETMASK = 0x891C
+
+    # if.h
+    IFF_UP = 0x1
+    IFF_RUNNING = 0x40
+
+    # bits/socket.h
+    AF_INET = 2
+
+    # char ifr_name[IFNAMSIZ=16]
+    ifr_name = struct.pack("@16s", b"lo")
+    def netdev_req(fd, req, data = b""):
+        # Pad and add interface name
+        data = ifr_name + data + (b'\x00' * (16 - len(data)))
+        # Return all data after interface name
+        return fcntl.ioctl(fd, req, data)[16:]
+
+    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_IP) as sock:
+        fd = sock.fileno()
+
+        # struct sockaddr_in ifr_addr { unsigned short family; uint16_t sin_port ; uint32_t in_addr; }
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 127, 0, 0, 1)
+        netdev_req(fd, SIOCSIFADDR, req)
+
+        # short ifr_flags
+        flags = struct.unpack_from('@h', netdev_req(fd, SIOCGIFFLAGS))[0]
+        flags |= IFF_UP | IFF_RUNNING
+        netdev_req(fd, SIOCSIFFLAGS, struct.pack('@h', flags))
+
+        # struct sockaddr_in ifr_netmask
+        req = struct.pack("@H", AF_INET) + struct.pack("=H4B", 0, 255, 0, 0, 0)
+        netdev_req(fd, SIOCSIFNETMASK, req)
+
 def disable_network(uid=None, gid=None):
     """
     Disable networking in the current process if the kernel supports it, else
@@ -1648,7 +1688,7 @@ def disable_network(uid=None, gid=None):

     ret = libc.unshare(CLONE_NEWNET | CLONE_NEWUSER)
     if ret != 0:
-        logger.debug("System doesn't suport disabling network without admin privs")
+        logger.debug("System doesn't support disabling network without admin privs")
         return
     with open("/proc/self/uid_map", "w") as f:
         f.write("%s %s 1" % (uid, uid))
--
2.25.1

The information in this communication may contain confidential or legally privileged information. It is intended solely for the use of the individual or entity it addresses and others authorized to receive it. If you are not an intended recipient, you are hereby notified that any disclosure, copying, distribution or action in reliance on the contents of this information is strictly prohibited and may be unlawful. If you have received this communication by error, please notify us immediately by responding to this e-mail and then delete it from your system. Critical TechWorks is not liable for the proper and complete transmission of the information in this communication nor for any delay in its receipt

This e-mail is environmentally friendly, just like Critical TechWorks, which lives in a paper-free atmosphere. Therefore, please consider the environment before printing it!
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#15757): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/15757">https://lists.openembedded.org/g/bitbake-devel/message/15757</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/103617369/6083838">https://lists.openembedded.org/mt/103617369/6083838</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:fbberton@gmail.com">fbberton@gmail.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------L468iJR5KWY5vCKgqQ4mCEj6--

