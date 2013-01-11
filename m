Received: from mail-ea0-f172.google.com ([209.85.215.172])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martiert@gmail.com>) id 1TtYY3-0003X1-7I
	for bitbake-devel@lists.openembedded.org;
	Fri, 11 Jan 2013 07:57:04 +0100
Received: by mail-ea0-f172.google.com with SMTP id f13so572259eaa.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jan 2013 22:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:message-id:date:from:user-agent:mime-version:to:cc
	:subject:references:in-reply-to:content-type;
	bh=A68YEB6lN9YqcB+RiiN8qX4R+mbgfNUJnJqMYr04Pgw=;
	b=Ov33RbFdNsJb50g3YxqAvLlTBkG1yvQ9o1YT0zkDaC8f7rTAW+BxwiBV7px0nlfBYP
	UBgRK63upy0irpl08GMcHmtgG6ZmY8P3EsRaadFDZLYC1LC26J/L6ijr4trxxkHwdtO2
	w9AnoZoCrV+BGS1NTvyEguwWQs6PXR5vxzLuf8Ij5HxgoCvmnxNjsbzNzUI3knGzZYQV
	JnwFKGWcb1/6jXR9UnqgpIoxsplWkjtH+d1IzaWIXNYsoXJr7vyijuT5sNBiucoJl40m
	HvJ3WWoo6uaRcJ/qqvzWjNHrWEsz5srP7hxBH+RLdLW940L3jV6SXzqHatowsTb/69Mw
	d3kQ==
X-Received: by 10.14.219.72 with SMTP id l48mr199464920eep.37.1357886507689;
	Thu, 10 Jan 2013 22:41:47 -0800 (PST)
Received: from [10.54.86.72] (64-103-25-233.cisco.com. [64.103.25.233])
	by mx.google.com with ESMTPS id w44sm7277899eep.6.2013.01.10.22.41.45
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 10 Jan 2013 22:41:46 -0800 (PST)
Message-ID: <50EFB428.8090700@gmail.com>
Date: Fri, 11 Jan 2013 07:41:44 +0100
From: Martin Ertsaas <martiert@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.11) Gecko/20121128 Thunderbird/10.0.11
MIME-Version: 1.0
To: Chris Larson <clarson@kergoth.com>
References: <1357807596-31587-1-git-send-email-martiert@gmail.com>
	<CABcZANkgffV7FwXX4NVyBA2mm1YOg+1en9x_oidsey+AkqdGBg@mail.gmail.com>
	<CABcZAN=_k4LrYhi8_t35pQ3mkToJKCLO9FxKGoFQ9fB+8+M5Vg@mail.gmail.com>
	<CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com>
In-Reply-To: <CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils.py: Use shutil.rmtree if the path we wish to remove is a directory.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 11 Jan 2013 06:57:04 -0000
Content-Type: multipart/alternative;
	boundary="------------040302000506010103000104"

--------------040302000506010103000104
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/13 15:18, Chris Larson wrote:
>
> On Thu, Jan 10, 2013 at 7:11 AM, Chris Larson <clarson@kergoth.com
> <mailto:clarson@kergoth.com>> wrote:
>
>
>     On Thu, Jan 10, 2013 at 7:10 AM, Chris Larson <clarson@kergoth.com
>     <mailto:clarson@kergoth.com>> wrote:
>
>         On Thu, Jan 10, 2013 at 1:46 AM, Martin Ertsaas
>         <martiert@gmail.com <mailto:martiert@gmail.com>> wrote:
>
>             On mac, os.unlink does not remove directories, and we
>             therefor have
>             to explicitly use shutil.rmtree if the path is a directory.
>             ---
>              lib/bb/utils.py |    5 ++++-
>              1 file changed, 4 insertions(+), 1 deletion(-)
>
>             diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>             index cef0fdd..8b6d3f5 100644
>             --- a/lib/bb/utils.py
>             +++ b/lib/bb/utils.py
>             @@ -561,7 +561,10 @@ def remove(path, recurse=False):
>                  import os, errno, shutil, glob
>                  for name in glob.glob(path):
>                      try:
>             -            os.unlink(name)
>             +            if os.path.isdir(name):
>             +                shutil.rmtree(name)
>             +            else:
>             +                os.unlink(name)
>                      except OSError as exc:
>                          if recurse and exc.errno == errno.EISDIR:
>                              shutil.rmtree(name)
>
>
>
>         Look 2 lines down, where it checks to see if the os.unlink
>         failed due to it being a directory and runs shutil.rmtree if
>         that's the case.
>
>
>     I'm guessing you're trying to use it without passing recurse=True.
>
>
> Having through about it further, I think it might be best to be alter
> the code to also handle the case where recurse==False and the path is
> a directory by calling os.rmdir(). Perhaps this would reduce confusion.
> -- 
> Christopher Larson

You are almost right. On normal folders, this will work with
recurse=True, but on /tmp folders you get: OSError: [Errno 1] Operation
not permitted: '/tmp/tmpl8qBDW' on the unlink call. This makes the if
test inside the except catching false, and nothing happens.

I'm not sure why this happens, as I am allowed to remove it using
shutil.rmtree. Making a folder in linux with the exact same permissions
does work however, so it seems to be some difference in how the os
handles the call.

Other than that, I feel that it is cleaner to have an explicit check
like this, and not use the exception framework for control flow. Which
means in the except just use raise, or just ignore it and let someone
else handle it like we actually do.
To get back the same functionality though, we should change the isdir
call to: 'if os.path.isdir(name) and recurse:'

Are you totally opposed to changing this? What I don't want to do is to
add exc.errno == errno.EPERM to the line, which will just bloath it.

- Martin

--------------040302000506010103000104
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 01/10/13 15:18, Chris Larson wrote:
    <blockquote
cite="mid:CABcZANnD8C4gZXEcRWfR8f_ftZjndOT9UJ5796SEigRqw6tohA@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra"><br>
          <div class="gmail_quote">On Thu, Jan 10, 2013 at 7:11 AM,
            Chris Larson <span dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:clarson@kergoth.com" target="_blank">clarson@kergoth.com</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div class="adM">
                <div class="h5"><br>
                  <div class="gmail_quote">On Thu, Jan 10, 2013 at 7:10
                    AM, Chris Larson <span dir="ltr">&lt;<a
                        moz-do-not-send="true"
                        href="mailto:clarson@kergoth.com"
                        target="_blank">clarson@kergoth.com</a>&gt;</span>
                    wrote:<br>
                    <blockquote class="gmail_quote" style="margin:0 0 0
                      .8ex;border-left:1px #ccc solid;padding-left:1ex">
                      <div>
                        <div class="gmail_quote">On Thu, Jan 10, 2013 at
                          1:46 AM, Martin Ertsaas <span dir="ltr">&lt;<a
                              moz-do-not-send="true"
                              href="mailto:martiert@gmail.com"
                              target="_blank">martiert@gmail.com</a>&gt;</span>
                          wrote:<br>
                          <blockquote class="gmail_quote"
                            style="margin:0 0 0 .8ex;border-left:1px
                            #ccc solid;padding-left:1ex">
                            <div>On mac, os.unlink does not remove
                              directories, and we therefor have<br>
                              to explicitly use shutil.rmtree if the
                              path is a directory.<br>
                              ---<br>
                               lib/bb/utils.py |    5 ++++-<br>
                               1 file changed, 4 insertions(+), 1
                              deletion(-)<br>
                              <br>
                              diff --git a/lib/bb/utils.py
                              b/lib/bb/utils.py<br>
                              index cef0fdd..8b6d3f5 100644<br>
                              --- a/lib/bb/utils.py<br>
                              +++ b/lib/bb/utils.py<br>
                              @@ -561,7 +561,10 @@ def remove(path,
                              recurse=False):<br>
                                   import os, errno, shutil, glob<br>
                                   for name in glob.glob(path):<br>
                                       try:<br>
                              -            os.unlink(name)<br>
                              +            if os.path.isdir(name):<br>
                              +                shutil.rmtree(name)<br>
                              +            else:<br>
                              +                os.unlink(name)<br>
                                       except OSError as exc:<br>
                                           if recurse and exc.errno ==
                              errno.EISDIR:<br>
                                               shutil.rmtree(name)</div>
                          </blockquote>
                        </div>
                        <br>
                        <br>
                      </div>
                      Look 2 lines down, where it checks to see if the
                      os.unlink failed due to it being a directory and
                      runs shutil.rmtree if that's the case.</blockquote>
                  </div>
                  <br>
                </div>
              </div>
              I'm guessing you're trying to use it without passing
              recurse=True.</blockquote>
          </div>
          <br>
          Having through about it further, I think it might be best to
          be alter the code to also handle the case where recurse==False
          and the path is a directory by calling os.rmdir(). Perhaps
          this would reduce confusion.<br>
          -- <br>
          Christopher Larson</div>
      </div>
    </blockquote>
    <br>
    You are almost right. On normal folders, this will work with
    recurse=True, but on /tmp folders you get: OSError: [Errno 1]
    Operation not permitted: '/tmp/tmpl8qBDW' on the unlink call. This
    makes the if test inside the except catching false, and nothing
    happens.<br>
    <br>
    I'm not sure why this happens, as I am allowed to remove it using
    shutil.rmtree. Making a folder in linux with the exact same
    permissions does work however, so it seems to be some difference in
    how the os handles the call.<br>
    <br>
    Other than that, I feel that it is cleaner to have an explicit check
    like this, and not use the exception framework for control flow.
    Which means in the except just use raise, or just ignore it and let
    someone else handle it like we actually do.<br>
    To get back the same functionality though, we should change the
    isdir call to: 'if os.path.isdir(name) and recurse:'<br>
    <br>
    Are you totally opposed to changing this? What I don't want to do is
    to add exc.errno == errno.EPERM to the line, which will just bloath
    it.<br>
    <br>
    - Martin<br>
  </body>
</html>

--------------040302000506010103000104--
