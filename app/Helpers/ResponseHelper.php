<?php

namespace App\Helpers;


class ResponseHelper
{
    /**
     * Format a success response.
     *
     * @param string $message
     * @param mixed $data
     * @param int $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public static function success(string $message, $data = null, int $statusCode = 200)
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'response' => $data,
        ], $statusCode);
    }

    /**
     * Format an error response.
     *
     * @param string $message
     * @param array|string|null $errors
     * @param int $statusCode
     * @return \Illuminate\Http\JsonResponse
     */
    public static function error(string $message, $errors = null, int $statusCode = 400)
    {
        return response()->json([
            'success' => false,
            'message' => $message,
            'errors' => $errors,
        ], $statusCode);
    }
}
