Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web08.3081.1610725131355768505
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Jan 2021 07:38:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gZOR6rv8;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: katutxakurra@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id s26so13708165lfc.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Jan 2021 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=eyQHEitMEAUkuLxzEU/Z+UVmitIaiA93Mb7QVXUQpa4=;
        b=gZOR6rv8HVciFtnZWDDcDEfjClBqQbiSCIxRU+vV5RRNZLwgOMJykp+5WWJvvllOgC
         aypUQOX1qtela5WGi9VihAmCryuQP7kREpC519bjKZ5QO/LTObE9NMgL8ax1eNHA3lRK
         hsTKp9QAHvQ2Hh1OWGk+95AVoWxAINgsx6ShaB19a1T5DdKI5NVlKq6URazvq/V7E29G
         ZE9KO7JO7npFPtMmF3lhL0K70qaMiPH7S/RLQxVYBungvIRwy3DSVNbbdnv3MDH5tfUG
         fI7JFtLlqK/zZ+ziugO3xTTLYQCTSCoGhYiRKjoG+1rHPbZlh6mF4o/bUw/7Kn7yewAL
         7TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eyQHEitMEAUkuLxzEU/Z+UVmitIaiA93Mb7QVXUQpa4=;
        b=VEpx0t+laGvXqs+1Jm3m4/dyNZpqCNzCciUrU8rYoGxJqN1zMGbdkP9UN9YKD2SKYT
         4ATKWKqfUEfdln/DEGTUWYSTABhqQXZK9mnFSf91kRHci2BAnWii/xLutLa/XbHa7mTb
         zO/rYzE27LxOMdAuP4TKjeth9fsTffNWXqtNmnEXfJ7DjJgaxQY9JO8vJbV0+RdGbq9v
         UDONBJkr+ZGuX5xs1RCRg/Hv5hTJQ0qN+dYRfMMgzZhSmNzxFj/igRDtJ4/QFZhfZ2jU
         NVZhIVjiMIXR7NAuCg4ctW0AY3FNgNWBEchzLbOnF02f5bevk0cWThNMHd9K9H6IxgkW
         +U/g==
X-Gm-Message-State: AOAM530IjgMVRjDbaZDCIGZcfMjR56lOKGMnM7V64s93UR0rMhvILhon
	astMQOOtZ0/wFlLXH+LlcmUiH9HJ10eHHmNKgH5ezuRbYIg=
X-Google-Smtp-Source: ABdhPJw9mLXVFwX/gOmdY3G9PHocCoq2FVAHNYajw0OtaY4r5cJ4+72l7hwXrvVw+FwDDdxBIyJAt4jjM9i0UD6yN0Q=
X-Received: by 2002:a19:7109:: with SMTP id m9mr5554553lfc.351.1610725129083;
 Fri, 15 Jan 2021 07:38:49 -0800 (PST)
MIME-Version: 1.0
From: "Katu Txakur" <katutxakurra@gmail.com>
Date: Fri, 15 Jan 2021 15:38:38 +0000
Message-ID: <CAM1ZcoWA6pT9iVunDREWGNMCY8DbbF_diUB_O_epnDLQsQspbg@mail.gmail.com>
Subject: [bitbake-devel] Perforce.py tar filename
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000026602105b8f22b10"

--00000000000026602105b8f22b10
Content-Type: text/plain; charset="UTF-8"

Hi,

The file
https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/perforce.py
that fetches code from Perforce repositories sets the name of the tar file
stored in the downloads folder in line 136:
    ud.localfile = d.expand('%s_%s_%s.tar.gz' % (cleanedhost, cleanedpath,
ud.revision))
It only cares about the path but not the 'module' where it will be mapped.
I had two recipes that map the same folder, but each had a destination
folder with a different name. When building an image containing both
recipes, the second one took the tar file in the downloads folder created
by the first one. As a consequence, the mapping was wrong and the image
failed to build.

I fixed it by adding the module to the name of the path. Is this a bug or a
design decision?

Thanks,
Katu

--00000000000026602105b8f22b10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>The file <a href=3D"http=
s://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/fetch2/perf=
orce.py">https://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/b=
b/fetch2/perforce.py</a> that fetches code from Perforce repositories sets =
the name of the tar file stored in the downloads folder in line 136:</div><=
div></div><div>=C2=A0=C2=A0=C2=A0 ud.localfile =3D d.expand(&#39;%s_%s_%s.t=
ar.gz&#39; % (cleanedhost, cleanedpath, ud.revision))<br>It only cares abou=
t the path but not the &#39;module&#39; where it will be mapped. I had two =
recipes that map the same folder, but each had a destination folder with a =
different name. When building an image containing both recipes, the second =
one took the tar file in the downloads folder created by the first one. As =
a consequence, the mapping was wrong and the image failed to build.</div><d=
iv><br></div><div>I fixed it by adding the module to the name of the path. =
Is this a bug or a design decision?</div><div><br></div><div>Thanks,</div><=
div>Katu<br></div><div>
<pre><code><br></code></pre>

</div></div>

--00000000000026602105b8f22b10--
