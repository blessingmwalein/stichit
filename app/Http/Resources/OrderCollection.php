<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class OrderCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @param Request $request
     * @return array<string, mixed>
     */
    public function toArray($request)
    {
        return [
            'data' => $this->collection->map(function ($order) {
                return new OrderResource($order);
            }),
            'meta' => [
                'current_page' => $this->currentPage(),
                'first_page_url' => $this->url(1),
                'from' => $this->firstItem(),
                'last_page' => $this->lastPage(),
                'last_page_url' => $this->url($this->lastPage()),
                'next_page_url' => $this->nextPageUrl(),
                'path' => $this->path(),
                'per_page' => $this->perPage(),
                'prev_page_url' => $this->previousPageUrl(),
                'to' => $this->lastItem(),
                'total' => $this->total(),
            ],
            'links' => $this->getPaginationLinks(),
        ];
    }

    /**
     * Get pagination links formatted as requested.
     *
     * @return array
     */
    private function getPaginationLinks()
    {
        $links = [];

        // Add "Previous" link
        $links[] = [
            'url' => $this->previousPageUrl(),
            'label' => '&laquo; Previous',
            'active' => $this->currentPage() == 1 ? false : true,
        ];

        // Add page links
        for ($page = 1; $page <= $this->lastPage(); $page++) {
            $links[] = [
                'url' => $this->url($page),
                'label' => (string) $page,
                'active' => $page == $this->currentPage(),
            ];
        }

        // Add "Next" link
        $links[] = [
            'url' => $this->nextPageUrl(),
            'label' => 'Next &raquo;',
            'active' => $this->currentPage() == $this->lastPage() ? false : true,
        ];

        return $links;
    }
}
