Return-Path: <maxim.uvarov@linaro.org>
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com
	[209.85.219.169])
	by mail.openembedded.org (Postfix) with ESMTP id 3BCFF7F798
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Nov 2019 10:42:34 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id q18so10208216ybq.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Nov 2019 02:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:from:date:message-id:subject:to;
	bh=1NJWmuJLTNL7l+KulyMejn5wJ26y9FFQu1/UDlH+PSw=;
	b=v4D2KDxfR9cLQstax/FpjdM84BiuFLg1WfqhhL7575nS/n1SeSseUpMAfzFFVhmOgV
	9a5DIIwdJjdUeE4XGx0jyemV1azX0JiL5vRtAL+0fciB2RFdSb00pbwaAC/cWtiBbgp1
	ZDuWtzqAlohZM3vCzwgS2sNUNZlOMAlIzoq4rq3FvOSNw7G2lO9XAaT47X9JaaKnSAqN
	gRVpeO7WHNtQqbwwzNdt3lnvuGCnSy+Fs9Q81k8jjjC/AZmtV9veE/dCxMt4wIbxaQNZ
	iW3xjCed+CNcU/lCHywJ8vCZyy9t0WkozKXqiYr4O+IeF+oi59xHiRveIXgIe+4XYF+J
	GjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
	bh=1NJWmuJLTNL7l+KulyMejn5wJ26y9FFQu1/UDlH+PSw=;
	b=GTdCtQcFM/i6r3fdJLYMAXzpOE3TTgNCm0vWoE4ZRWvljThQOfAsSFhGjxkBVs4b7L
	k44EpAaKXIFl3qgi2E4h8r3AX7tgJOTD4YOqzehZyQQ0+vmJkjNksv9AJazBsyLibGOu
	hZ5nGXDNZ6mib0B2Y2dO5bYp5itqw7eR4cJzTQeKsXuN2C5YXtEP8eIKtkBsR2JDSSpt
	D2ZWHx57ezoCB5kblvsHhws3T6zmEo3eQQ6qEVh33lymSGu6i1LrqpsvD9YObYLMLyiU
	g1NNFjeVacm6bqWsw0tCvtGnXylWpZ2/4Wdjko25V8KsVffV4XBasKJEJhX3XjqJR0nN
	UFhA==
X-Gm-Message-State: APjAAAVX32LOTWthsiH+eizG7ugM7Ar1o0z4LPDvgvUn9R06kfFiuzKP
	suGFC2pE8cI/xXSUyApKAh1kdc/nc9zYpujbWBq2YeF0bvQ=
X-Google-Smtp-Source: APXvYqzrO7M9tZZV5mF/rJge92wlTBnaHffCbNzKwAFhDSkn2Z5hMwt/7bE3KU/dM3F9Jm29PR2hCNrh3AJNzvJewCo=
X-Received: by 2002:a25:af41:: with SMTP id c1mr1465151ybj.187.1573036954801; 
	Wed, 06 Nov 2019 02:42:34 -0800 (PST)
MIME-Version: 1.0
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 6 Nov 2019 13:42:24 +0300
Message-ID: <CAD8XO3ZVwS0B-u064nEOPMzx8ngft2q8S3KM9VCG+V61PA3_aA@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
X-Mailman-Approved-At: Wed, 06 Nov 2019 11:07:36 +0000
Subject: hg fix was not merged
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 06 Nov 2019 10:42:34 -0000
Content-Type: text/plain; charset="UTF-8"

Is there any reason why this patch was not merged?
http://lists.openembedded.org/pipermail/bitbake-devel/2017-November/009097.html

Patch fixes hg fetched.

Maxim.

