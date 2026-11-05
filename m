Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6276.1793912760202207284
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Nov 2026 13:06:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=gnCfzxIY;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso11837175e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793912758; x=1794517558; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nTlZiXU6e5t4lK+GyDSMX8RLYbTOFFlFC927BiStm6Y=;
        b=gnCfzxIYouFxSuQlJyfrEMY2uqs/PdGRJGx22pb027RIorSnSnHn0qe6jFTVn8HH8X
         fVOTZVmRvxwMC/tCV6mOvjXW8O5rhzVudMzKoLr38lCjhAdDv1URFvnEO/YTvLn06jL/
         Vk6RJV0TAZ/Q4gI2yge1fzps1ygz6xLcu7Yr3SBrE/Jr7XkCQLmEtWdbv0ZlU26ROVGX
         Zi2/39wPcQLv2EbaXqOgry4c+r8ZoPU+OO02SJL/8LW41moGIRjDEKqv2JwE3xB4Gxkk
         vEtQSZ8mfaPdL8XoUnInD0XfBvxeEYqyfjyYcBiovol47kDX0zWaaphEFHd4KtPOFVIv
         y1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793912758; x=1794517558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nTlZiXU6e5t4lK+GyDSMX8RLYbTOFFlFC927BiStm6Y=;
        b=N5u6hX7g7vGAIXK1cF+2ZIipgm6WUVdltmZezZC+ZPMVbYkZH1snL8sBsZ87L9vNVV
         lJOnKdTGOIubTuc5j0+Eyah80FTto3yn6kg6Dxor8zjLjtkhTSSC10RGy8z9xHt603zT
         ifQ663MedEIXi/Q+otdpPycRwjl8++kGa/A399xppIzDX9gTsRT28rGXyyAFlkRYyISe
         iLc6hBBjvEGIzNYow0sGyz6MWMJszqrm1Vh34JsoAGI+ToW01/pz310mrAjGdX7I69TA
         pLPMVFYx5cJ8KUl+Hq5jADUnAiFD6T0Oe9pbVEHczVpfiATGgkv1QqwLOGCU2tTN+JJr
         ox/g==
X-Forwarded-Encrypted: i=1; AKwUvBwF1z7GI+wyTSsoBqgUHkk8Bhz/Lg2krYS4nViZwz+yBQvPvhYsqxSgBW2KZVxxs9UI506QJMrq/Yqjf7ev@lists.openembedded.org
X-Gm-Message-State: APuU4Z/SuD+9DnZDT0ZonPj6vsBLKd01CtneT3H78tR6NtWgVFiiKaFl
	0K8iDL4uOQ/AjWu5NCgx+DkWoQWp+sH2AkcyZQQK5RUE22et0Cj0YPBy
X-Gm-Gg: AYBFou35E3K7HYViScYChrcRDKHJC7t3u1jxCl6Q01I6GRqnw52Fe8SC7J36Pd7tyUB
	MU8kKLYJ5TK/j2c6Zcd9yxfXrx0TMWbDgot79+me3eAQMgMNolQP+gZBy3ukLTOoCuV1k3Azok7
	a7QZ31HTKyOflc7WFSaBXQLlWAL75B21gLZW6ul7SKUsfkibwf8N0USlMA74maPHeoRdjpCFhwb
	IVzvGN0dqU2PTYPNANxRv/quF7lh4gQ6ejNXw4tByrF4/HQc8X2c1p3lzqhWxQ2LLO36qU3Ez5n
	9AXgJUCB55prDEV4q126xP9KvwLXTPkBRCg1kCaj6hOJ4tRbuFl/U32iw8iuHxbGnaYQA0HyzCA
	KkVdN1XlFjNXgLfMsjm99AgLMVLWocTMVAELi97wOJT96LWX508yihNxLkyCDVdX9IWvMlwlRHI
	+ETPYBRjnK8AuU+wjvWRl3OHAZVOqPoBxNiPsAbaWv5YYdxSOqvgBecKun7EN4RanPmvVBEquf0
	dZeXSKI3TOr/z2IXI1RlkTvaiQ2YwpVgCluscGg2P/9Yo1pR7Bukhczq7D4iYgUts5yQl9dm5BM
	gIV4l3qpFb305EaN4mgE6NN/O9s9pkpFcLFu04QVjf0YYw==
X-Received: by 2002:a05:600c:c168:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4b6e054a43fmr4420175e9.31.1793912758051;
        Thu, 05 Nov 2026 13:05:58 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6af5f0c63sm16507095e9.6.2026.11.05.13.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:05:55 -0800 (PST)
From: "Stefano Tondo" <stondo@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org,
	Joshua Watt <JPEWhacker@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	Adrian Freihofer <adrian.freihofer@siemens.com>,
	Patrick Wicki <patrick.wicki@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: Re: [RFC] spdx30: name, version and purl for dependency downloads
Date: Thu,  5 Nov 2026 22:05:54 +0100
Message-ID: <20261105210554.1648512-1-stondo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CANNYZj9=G4+jmRx7UJMYbsp2xwDxwSmm+Gv2HxcPJtOen_9LUA@mail.gmail.com>
References: <CANNYZj9=G4+jmRx7UJMYbsp2xwDxwSmm+Gv2HxcPJtOen_9LUA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 05 Nov 2026 21:11:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20400
Content-Type: text/plain; charset="utf-8"

On Thu, 5 Nov 2026 at 21:26, Alexander Kanavin <alex.kanavin@gmail.com> wrote:
> I'm afraid I am missing context, which is hardly surprising because I
> did no spdx work until now. What are the language dependencies? Does
> something require or recommend them? Is there a normative document
> that defines them? The email talks about how the implementation
> works, but says nothing about what the problem is.

Hi Alex,

You are right: I jumped straight into the how and never explained
the why. Let me start from the problem.

Take crucible from meta-oe. It is a Go program, and besides its own
code it compiles in 36 Go modules fetched with gomod://, one of them
golang.org/x/net v0.39.0. Now imagine the next advisory for
golang.org/x/net comes out, and whoever ships a device with crucible
on it is asked: "Is your product affected?"

The SPDX that Yocto writes for the image should answer that, but it
can't. The module is in there, but only as a downloaded file named
"golang.org.x.net@v0.39.0.zip" with the location
gomod://golang.org/x/net: no version field and no package URL, so
no scanner recognises it. cve-check does not see it either, because
it only knows the CPEs of recipes. The answer ends up being someone
reading file names by hand, for every advisory and every image.

That is what I meant by language dependencies: the packages of a
language's own package manager that a recipe compiles in without
having a recipe of their own. Rust crates (crate://), Go modules
(gomod://) and npm packages (npmsw://) are the cases Yocto can fetch
today. For the first two the problem is the one above: present, but
not identifiable. Git submodules and the dependencies listed in an
npm shrinkwrap file are worse off: they are not recorded at all.

Why this matters now, with the documents that ask for it:

- The EU Cyber Resilience Act (Regulation (EU) 2024/2847), Annex I,
  Part II, point 1, requires manufacturers to identify and document
  the components of their products, including by drawing up an SBOM
  in a commonly used, machine-readable format covering at the very
  least the top-level dependencies. It applies from December 2027 to
  products sold in the EU, so many Yocto users will have to deliver
  one.

- BSI TR-03183-2, the German technical guideline that spells out
  what such an SBOM contains, asks for the dependencies of everything
  that is delivered (section 5.1), each with a name, a version and an
  identifier such as a purl or CPE (section 5.2).

- The "2026 Minimum Elements for a Software Bill of Materials",
  published in July by CISA together with BSI, ANSSI and other
  agencies, asks for transitive dependencies and an identifier per
  component, and gives the example above as its reason: a recipient
  should be able to conclude that a new vulnerability does not affect
  them when the SBOM does not list the component.

Yocto already knows all of this at fetch time; the RFC is only about
writing it into the SPDX it already produces, without changing how
anything is fetched. I hope that makes the context clearer, and I am
happy to go into more detail on any of it.

Thanks,
Stefano
